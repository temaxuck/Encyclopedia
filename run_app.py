from encyclopedia import app, db
from encyclopedia.models import User, Pyramid

@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Pyramid': Pyramid}

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)