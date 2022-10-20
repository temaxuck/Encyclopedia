from encyclopedia.views import *
from encyclopedia.forms import UploadPyramidForm, ConfirmPyramidDeletionForm, RelationSubform, ExplicitFormulaSubform

pyramidbp = Blueprint('pyramid', __name__)

@pyramidbp.after_request 
def after_request(response):
    header = response.headers
    header['Access-Control-Allow-Origin'] = '*'
    # Other headers can be added here if needed
    return response

@pyramidbp.route('/<snid>', methods=['GET', 'POST'])
def pyramid(snid: int):
    try:
        pyramid = Pyramid.query.filter_by(sequence_number=snid).first()
    except sqlalchemy.exc.DataError:
        return redirect(url_for('errors.error404'))


    if not pyramid:
        return redirect(url_for('errors.error404'))

    deleteform = ConfirmPyramidDeletionForm()

    if deleteform.validate_on_submit():
        if current_user.moderator:
            from encyclopedia.managers import PyramidManager
            
            PyramidManager(db.session).delete(pyramid)
            flash(f'The pyramid #{pyramid.sequence_number} has been successfully deleted!', 'success')
            
            return redirect(url_for('general.home'))
        
        return render_template('page_not_found.html'), 403

    return render_template('pyramid.html', pyramid=pyramid, PyramidModel=Pyramid, deleteform=deleteform)


@pyramidbp.route('/upload', methods=['POST', 'GET'])
@login_required
def upload_pyramid():
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("general.home"))
        
    form = UploadPyramidForm()

    if form.validate_on_submit():
        try:
            alreadyExist = Pyramid.query.filter_by(sequence_number=form.sequenceNumber.data).count() > 0
            if alreadyExist:
                flash(f'Such pyramid already exists', 'danger')
                return redirect(url_for('pyramid.upload_pyramid'))

            pyramid = Pyramid(form.sequenceNumber.data)

            rels = form.relations.data
            
            for i, gf in enumerate(form.generatingFunction):
                isMain = False
                if gf.f_name.data == 'U' or gf.f_name.data == 'u' or i == len(form.generatingFunction) - 1:
                    isMain = True
                pyramid.add_generating_function(gf.f_name.data, gf.f_vars.data, gf.f_expr.data, isMain)
            
            for ef in form.explicitFormula:
                pyramid.add_explicit_formula(form.ef_vars.data, ef.f_expr.data, ef.f_condition.data)

            pyramid.init_special_value()
            alreadyExist = Pyramid.query.filter_by(__special_hashed_value__=pyramid.__special_hashed_value__).count() > 0
            
            if alreadyExist:
                flash(f'Pyramid with such formulas probably already exists. Make sure generating function and explicit formula are unique', 'danger')
                return redirect(url_for('pyramid.upload_pyramid'))

            db.session.add(pyramid)
            db.session.commit()


            for i, relation in enumerate(form.relations.data):
                try:
                    pyramid.add_relation(Pyramid.query.filter_by(sequence_number=relation.get('relatedto_pyramid')).first().id, relation.get('tag'))
                except Exception:
                    flash(f"Could not add a relation between pyramids #{relation.get('relatedto_pyramid')} and #{pyramid.sequence_number}", 'danger')
                    return redirect(url_for('pyramid.edit_pyramid', snid=pyramid.sequence_number))
                    
            current_user.add_pyramid(pyramid)
            db.session.commit()
            flash('The pyramid has been added!', 'success')

        except:
            flash('Could not process formulas!', 'danger')

        return redirect(url_for('pyramid.pyramid', snid=pyramid.sequence_number))
    
    return render_template('upload_pyramid.html', form=form)

@pyramidbp.route('/<snid>/edit', methods=['POST', 'GET'])
@login_required
def edit_pyramid(snid: int):
    from encyclopedia.models import relations
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("general.home"))
        
    form = UploadPyramidForm()
    pyramid = Pyramid.query.filter_by(sequence_number=snid).first()

    if not pyramid:
        return render_template('page_not_found.html'), 404

    if form.validate_on_submit():
        try:
            for i, gf in enumerate(form.generatingFunction):
                isMain = False
                if gf.f_name.data == 'U' or gf.f_name.data == 'u' or i == len(form.generatingFunction) - 1:
                    isMain = True
                
                try:
                    pyramid.generating_function[i].change_formula(
                            function_name=gf.f_name.data, 
                            variables=gf.f_vars.data, 
                            expression=gf.f_expr.data, 
                        )
                except IndexError:
                    pyramid.add_generating_function(gf.f_name.data, gf.f_vars.data, gf.f_expr.data, isMain)
            
            for i, ef in enumerate(form.explicitFormula):
                try:
                    pyramid.explicit_formula[i].change_formula(
                        expression=ef.f_expr.data, 
                        variables=form.ef_vars.data,
                        limitation=ef.f_condition.data
                    )
                except IndexError:
                    pyramid.add_explicit_formula(form.ef_vars.data, ef.f_expr.data, ef.f_condition.data)
            
            pyramid.delete_all_relations()
                    
            for i, relation in enumerate(form.relations.data):
                try:
                    pyramid.add_relation(Pyramid.query.filter_by(sequence_number=relation.get('relatedto_pyramid')).first().id, relation.get('tag'))
                except Exception as e:
                    print(e)
                    flash(
                        f"Could not add a relation between pyramids #{relation.get('relatedto_pyramid')} and #{pyramid.sequence_number}. Make sure pyramid #{relation.get('relatedto_pyramid')} exists",
                        'danger')
                    return redirect(url_for('pyramid.edit_pyramid', snid=pyramid.sequence_number))
            
            db.session.add(pyramid)
                    
            pyramid.init_special_value()
            db.session.commit()
            flash('The pyramid has been edited!', 'success')

        except:
            flash('Could not process formulas!', 'danger')

        return redirect(url_for('pyramid.pyramid', snid=pyramid.sequence_number))
    
    elif request.method == 'GET':
        form.sequenceNumber.data = pyramid.sequence_number
        
        if pyramid.generating_function:
            form.generatingFunction[0].f_name.data = pyramid.generating_function[0].function_name
            form.generatingFunction[0].f_vars.data = pyramid.generating_function[0].get_variables_as_str()
            form.generatingFunction[0].f_expr.data = pyramid.generating_function[0].expression

        if pyramid.explicit_formula:
            form.ef_name.data = pyramid.explicit_formula[0].function_name
            form.ef_vars.data = pyramid.explicit_formula[0].get_variables_as_str()
            form.explicitFormula[0].f_expr.data = pyramid.explicit_formula[0].expression
            form.explicitFormula[0].f_condition.data = pyramid.explicit_formula[0].limitation

        for i in range(len(pyramid.generating_function) - 1):
            gf = pyramid.generating_function[i+1]
            gform = GeneratingFunctionForm()
            gform.f_name = gf.function_name
            gform.f_vars = gf.get_variables_as_str()
            gform.f_expr = gf.expression
            form.generatingFunction.append_entry(gform)

        for i in range(len(pyramid.explicit_formula) - 1):
            ef = pyramid.explicit_formula[i+1]
            eform = ExplicitFormulaSubform()
            eform.f_expr=ef.expression
            eform.f_condition=ef.limitation
            form.explicitFormula.append_entry(eform)
            
        if pyramid.relations.count() > 0:
            rels = pyramid.relations.all()
            for rel in rels:
                relform = RelationSubform()
                relform.relatedto_pyramid = rel.sequence_number
                relform.tag = pyramid.get_relation(rel.id).get('tag')
                form.relations.append_entry(relform)

    return render_template('upload_pyramid.html', form=form, pyramid=pyramid)
