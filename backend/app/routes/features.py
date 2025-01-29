# app/routes/station.py
from flask import Blueprint, request, jsonify
from ..models.features import Feature
from .. import db

feature_bp = Blueprint('feature', __name__)


@feature_bp.route('/api/feature', methods=['GET'])
def get_features():
    try:

        # 查询指定城市ID的站点信息
        features = Feature.query.all()

        # 转换为JSON格式
        result = [{
            'id': feature.id,
            'name': feature.name,
        } for feature in features]

        return jsonify({
            'code': 200,
            'message': 'success',
            'data': result
        })

    except Exception as e:
        return jsonify({
            'code': 500,
            'message': str(e),
            'data': None
        }), 500

