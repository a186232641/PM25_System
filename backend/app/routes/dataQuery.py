import os
import numpy as np
import pandas as pd
from flask import Blueprint, request, jsonify
from datetime import datetime, timedelta
from ..utils.Mapping import CityMapping

dataquery_bp = Blueprint('dataquery', __name__)
city_mapping = CityMapping()

def load_npy_data(file_path):
    """加载.npy文件数据"""
    try:
        file_path = os.path.abspath(file_path)  # 获取绝对路径
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"文件不存在: {file_path}")
        return np.load(file_path)
    except Exception as e:
        raise Exception(f"Error loading data: {str(e)}")

def get_time_series():
    """生成时间序列"""
    start_time = datetime(2015, 1, 1, 0, 0)
    end_time = datetime(2018, 12, 31, 21, 0)
    time_points = pd.date_range(start=start_time, end=end_time, freq='3H')
    return [t.strftime('%Y-%m-%d %H:%M:%S') for t in time_points]

@dataquery_bp.route('/api/historical/data', methods=['GET'])
def get_historical_data():
    try:

        # 获取请求参数
        dataset_id = request.args.get('dataset_id')
        station_id = request.args.get('station_id', type=int) - 1
        feature_id = request.args.get('feature_id', type=int)

        # 验证参数存在性
        if not all([dataset_id, station_id is not None, feature_id is not None]):
            return jsonify({
                'code': 400,
                'message': '缺少必需参数',
                'data': None
            })

        # 获取数据文件路径
        file_path = city_mapping.get_dataset_path(dataset_id)
        if not file_path:
            return jsonify({
                'code': 400,
                'message': f'无效的数据集ID: {dataset_id}',
                'data': None
            })

        # 验证文件是否存在
        if not os.path.exists(file_path):
            return jsonify({
                'code': 404,
                'message': f'数据文件不存在: {file_path}',
                'data': None
            })

        # 执行ID映射
        try:
            mapped_station, mapped_feature = city_mapping.map_station_and_feature(
                dataset_id,
                station_id,
                feature_id
            )

            if not city_mapping.is_valid_mapping(mapped_station, mapped_feature):
                return jsonify({
                    'code': 400,
                    'message': f'无效的映射: 站点ID {station_id} 或特征ID {feature_id}',
                    'data': None
                })

        except Exception as e:
            return jsonify({
                'code': 400,
                'message': f'参数映射错误: {str(e)}',
                'data': None
            })

        # 加载并获取数据
        try:
            data = load_npy_data(file_path)
            time_series_data = data[:, mapped_station, mapped_feature]
        except IndexError:
            return jsonify({
                'code': 400,
                'message': '数据索引超出范围',
                'data': None
            })
        except Exception as e:
            return jsonify({
                'code': 500,
                'message': f'数据加载错误: {str(e)}',
                'data': None
            })

        # 生成时间序列
        timestamps = get_time_series()

        # 组织数据，过滤NaN值
        historical_data = [
            {
                'timestamp': timestamp,
                'value': round(float(value), 3)
            }
            for timestamp, value in zip(timestamps, time_series_data)
            if not np.isnan(value)
        ]

        if not historical_data:
            return jsonify({
                'code': 404,
                'message': '未找到有效数据',
                'data': None
            })

        return jsonify({
            'code': 200,
            'message': 'success',
            'data': {
                'timeseries': historical_data
            }
        })

    except Exception as e:
        return jsonify({
            'code': 500,
            'message': f'服务器内部错误11111: {str(e)}',
            'data': None
        })
