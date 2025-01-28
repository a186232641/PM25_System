# config.py
class Config:
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:han12300@localhost/pm25_predict'
    SQLALCHEMY_TRACK_MODIFICATIONS = False