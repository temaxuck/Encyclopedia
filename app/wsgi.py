from encyclopedia import create_app, db

app = create_app()

if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0", port=8080)
    
@app.before_first_request
def create_tables():
    db.create_all()
