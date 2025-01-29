import numpy as np
import pandas as pd
from datetime import datetime, timedelta


def inspect_specific_data(station_idx=0, feature_idx=0, show_rows=5):
    """
    查看特定站点和特征的数据，包含时间戳信息

    Args:
        station_idx: 站点索引
        feature_idx: 特征索引
        show_rows: 显示的行数
    """
    try:
        # 加载数据
        file_path = '/Users/hanfeilong/Documents/SCI论文下载与阅读/大论文/code/backend/app/data/jingjinji.npy'
        data = np.load(file_path)

        # 生成时间序列
        start_time = datetime(2015, 1, 1, 0, 0)
        end_time = datetime(2018, 12, 31, 21, 0)
        time_points = pd.date_range(start=start_time, end=end_time, freq='3H')

        print(f"数据形状: {data.shape}")
        print(f"时间序列长度: {len(time_points)}")
        print(f"\n选择站点 {station_idx}, 特征 {feature_idx} 的前 {show_rows} 个时间点数据:")
        print("-" * 50)

        # 获取特定站点和特征的时间序列数据
        time_series = data[:, station_idx, feature_idx]
        print(time_series[0:5])
    finally: pass


if __name__ == "__main__":
    # 可以修改这里的参数来查看不同站点和特征的数据
    inspect_specific_data(station_idx=0, feature_idx=0, show_rows=5)

    # 打印特征映射关系
    feature_list = [17, 4, 5, 6, 7, 10, 13, 14, 15]
    print("\n特征映射关系:")
    for idx, feature_id in enumerate(feature_list):
        print(f"索引 {idx}: 特征ID {feature_id}")