# app/routes/station.py
from flask import Blueprint, request, jsonify
from ..models.station import Station
from .. import db

station_bp = Blueprint('station', __name__)


# 获取指定数据集的站点信息
@station_bp.route('/api/stations/dataset', methods=['GET'])
def get_dataset_stations():
    try:
        dataset_id = request.args.get('dataset_id', type=int)

        if dataset_id not in [1, 2]:
            return jsonify({'error': 'Invalid dataset ID'}), 400

        # 定义数据集对应的城市ID
        dataset_cities = {
            1: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 41, 42, 43],
            2: [18, 39, 137, 23, 26, 27, 73, 138, 25, 24, 19, 31, 34, 35, 17]
        }

        # 查询指定城市ID的站点信息
        stations = Station.query.filter(Station.id.in_(dataset_cities[dataset_id])).all()

        # 转换为JSON格式
        result = [{
            'id': station.id,
            'name': station.name,
            'longitude': station.longitude,
            'latitude': station.latitude
        } for station in stations]

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


# 获取所有数据集信息
@station_bp.route('/api/stations/datasets', methods=['GET'])
def get_datasets():
    try:
        datasets = [
            {
                'id': 1,
                'name': '京津冀数据集',
                'description': '京津冀城市监测站点',
                'city_count': 19
            },
            {
                'id': 2,
                'name': '长三角数据集',
                'description': '长三角城市监测站点',
                'city_count': 15
            }
        ]

        return jsonify({
            'code': 200,
            'message': 'success',
            'data': datasets
        })

    except Exception as e:
        return jsonify({
            'code': 500,
            'message': str(e),
            'data': None
        }), 500
