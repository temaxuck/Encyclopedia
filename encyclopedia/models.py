from encyclopedia import db, login_manager
from flask_login import UserMixin

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

relations = db.Table('relations',                                               # Many to many relation (Pyramid object
    db.Column('linked_pyramid_id', db.Integer, db.ForeignKey('pyramid.id')),    # being linked with another Pyramid object)
    db.Column('relatedto_pyramid_id', db.Integer, db.ForeignKey('pyramid.id'))
)

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(30), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    profile_imagefile = db.Column(db.String(20), nullable=False, default='default.png')
    password = db.Column(db.String(60), nullable=False)
    posts = db.relationship('Pyramid', backref='author', lazy=True)

    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password = password

    def __repr__(self):
        return f'User({self.id}, "{self.username}", "{self.email}", "{self.profile_imagefile}")'
    
class Pyramid(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sequence_number = db.Column(db.Integer, unique=True, nullable=False)
    generating_function = db.Column(db.String(140), unique=True, nullable=False)
    explicit_formula = db.Column(db.String(140), unique=True, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    relations = db.relationship('Pyramid', secondary = relations, primaryjoin=(relations.c.linked_pyramid_id == id),
        secondaryjoin=(relations.c.relatedto_pyramid_id == id),
    backref=db.backref('linked', lazy='dynamic'), lazy='dynamic')

    def __init__(self, sequence_number, generating_function, explicit_formula):
        self.sequence_number = sequence_number
        self.generating_function = generating_function
        self.explicit_formula = explicit_formula
    
    def __repr__(self):
        return f'Pyramid({self.id}, {self.sequence_number}, "{self.generating_function}", "{self.explicit_formula}")'

    def isLinked(self, pyramid):
        return self.relations.filter(relations.c.relatedto_pyramid_id == pyramid.id).count() > 0

    def add_relation(self, pyramid):
        if not self.isLinked(pyramid) and not pyramid.isLinked(self):
            self.relations.append(pyramid)
            pyramid.relations.append(self)