from encyclopedia.views import *

pyramidbp = Blueprint('pyramid', __name__)

@pyramidbp.route('/<snid>', methods=['POST', 'GET'])
def pyramid(snid: int):
    pyramid = Pyramid.query.filter_by(sequence_number=snid).first()

    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))

    return render_template('pyramid.html', pyramid=pyramid, PyramidModel=Pyramid)


@pyramidbp.route('/upload', methods=['POST', 'GET'])
@login_required
def upload_pyramid():
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("general.home"))
        
    form = UploadPyramidForm()

    if form.validate_on_submit():
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
            flash(f'Such pyramid already exists', 'danger')
            return redirect(url_for('pyramid.upload_pyramid'))

        db.session.add(pyramid)

        # if rels:
        #     for rel in rels.split(','):
        #         try:
        #             rel = int(rel)
        #             related_pyramid = Pyramid.query.filter_by(sequence_number = rel).first()
        #             if related_pyramid is None:
        #                 flash(f'Could not get Pyramid#{rel}', 'danger')
        #             else:
        #                 pyramid.add_relation(related_pyramid)
        #         except ValueError:
        #             flash(f'Could not convert Pyramid #{pyramid.sequence_number} relation {rel} to int', 'danger')

        current_user.add_pyramid(pyramid)
        db.session.commit()
        flash('The pyramid has been added!', 'success')

        return redirect(url_for('general.home', username=current_user.username))
    
    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
    
    return render_template('upload_pyramid.html', form=form)

@pyramidbp.route('/<snid>/edit', methods=['POST', 'GET'])
@login_required
def edit_pyramid(snid: int):
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("general.home"))
        
    form = UploadPyramidForm()
    pyramid = Pyramid.query.filter_by(sequence_number=snid).first()

    if form.validate_on_submit():
        rels = form.relations.data

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
        
        if form.relations.data != pyramid.get_relations_as_str():
            # pyramid.relations = []
            for relation in pyramid.relations.all():
                pyramid.delete_relation(relation)
            for rel in form.relations.data.split(','):
                related = Pyramid.query.filter_by(sequence_number=int(rel)).first()
                pyramid.add_relation(related)


        pyramid.init_special_value()
        db.session.commit()
        flash('The pyramid has been edited!', 'success')

        return redirect(url_for('pyramid.pyramid', snid=pyramid.sequence_number))
    
    elif request.method == 'GET':
        form.sequenceNumber.data = pyramid.sequence_number
        
        form.generatingFunction[0].f_name.data = pyramid.generating_function[0].function_name
        form.generatingFunction[0].f_vars.data = pyramid.generating_function[0].get_variables_as_str()
        form.generatingFunction[0].f_expr.data = pyramid.generating_function[0].expression

        form.ef_name.data = pyramid.explicit_formula[0].function_name
        form.ef_vars.data = pyramid.explicit_formula[0].get_variables_as_str()
        form.explicitFormula[0].f_expr.data = pyramid.explicit_formula[0].expression
        form.explicitFormula[0].f_condition.data = pyramid.explicit_formula[0].limitation

        # form.relations[0].relatedto_pyramid.data = pyramid.relations[0].sequence_number if pyramid.relations else ''
        # form.relations[0].tag.data = 'Reciprocal' if pyramid.relations else ''
  
        for i in range(len(pyramid.generating_function) - 1):
            gf = pyramid.generating_function[i+1]
            gform = GeneratingFunctionForm()
            gform.f_name = gf.function_name
            gform.f_vars = gf.get_variables_as_str()
            gform.f_expr = gf.expression
            form.generatingFunction.append_entry(gform)

        for i in range(len(pyramid.explicit_formula) - 1):
            ef = pyramid.explicit_formula[i+1]
            eform = ExplicitFormulaForm()
            eform.f_expr=ef.expression
            eform.f_condition=ef.limitation
            form.explicitFormula.append_entry(eform)
            
        if pyramid.relations.all():
            form.relations[0].relatedto_pyramid.data = pyramid.relations[0].sequence_number
            form.relations[0].tag.data = 2 
        else:
            form.relations[0].relatedto_pyramid.data = ''
            form.relations[0].tag.data = '' 
            print(form.relations[0].tag.data)

  		# for i in range(len(pyramid.explicit_formula) - 1):
        #     ef = pyramid.explicit_formula[i+1]
        #     eform = ExplicitFormulaForm()
        #     eform.f_expr=ef.expression
        #     eform.f_condition=ef.limitation
        #     form.explicitFormula.append_entry(eform)
            
        # form.relations.choices = pyramid.get_relations_as_str()
    
    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
    
    return render_template('upload_pyramid.html', form=form, pyramid=pyramid)
