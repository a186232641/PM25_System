# import sys
# import os
#
# sys.path.append(os.path.dirname(os.path.abspath(__file__)))
#
# from app import create_app
#
# app = create_app()
#
# if __name__ == '__main__':
#     app.run(debug=True, port=5000)
from app import create_app, db

app = create_app()

with app.app_context():
    try:
        db.engine.connect()
        print("Database connection successful!")
    except Exception as e:
        print(f"Database connection failed: {e}")

if __name__ == '__main__':
    app.run(debug=True)