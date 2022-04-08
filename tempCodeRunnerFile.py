.drop(db.engine)
Variable.__table__.drop(db.engine)
db.create_all(