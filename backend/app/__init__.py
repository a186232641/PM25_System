# app/__init__.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from config import Config

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # 初始化扩展
    db.init_app(app)
    CORS(app)  # 启用跨域支持

    # 注册蓝图
    from .routes.station import station_bp
    app.register_blueprint(station_bp, url_prefix='/')

    return app