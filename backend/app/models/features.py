# app/models/station.py
from .. import db
from datetime import datetime


class Feature(db.Model):
    __tablename__ = 'features'  # 使用你实际创建的表名

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)


    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name
        }