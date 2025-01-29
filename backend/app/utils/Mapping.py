import os

class CityMapping:
    def __init__(self):
        # 数据集映射
        self.dataset_mapping = {
            '1': os.path.abspath('/Users/hanfeilong/Documents/SCI论文下载与阅读/大论文/code/backend/app/data/jingjinji.npy'),
            '2': os.path.abspath('/Users/hanfeilong/Documents/SCI论文下载与阅读/大论文/code/backend/app/data/changsanjiao.npy'),
        }

        # city_list [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 40, 41, 42]
        self.city_list_mapping = {
            0: 0,
            1: 1,
            2: 2,
            3: 3,
            4: 4,
            5: 5,
            6: 6,
            7: 7,
            8: 8,
            9: 9,
            10: 10,
            11: 11,
            12: 12,
            13: 13,
            14: 14,
            15: 15,
            40: 16,
            41: 17,
            42: 18
        }

        # feature列表 [17,4,5,6,7,10,13,14,15]
        self.feature_mapping = {
            17: 0,
            3: 1,
            4: 2,
            5: 3,
            6: 4,
            9: 5,
            12: 6,
            13: 7,
            14: 8
        }

        # city_list2 [17,38,136,22,25,26,72,137,24,23,18,30,33,34,16]
        self.city_list2_mapping = {
            17: 0,
            38: 1,
            136: 2,
            22: 3,
            25: 4,
            26: 5,
            72: 6,
            137: 7,
            24: 8,
            23: 9,
            18: 10,
            30: 11,
            33: 12,
            34: 13,
            16: 14
        }

        # 保存数据集和城市列表的对应关系
        self.dataset_city_mapping = {
            '1': 'city_list',    # 京津冀使用 city_list 映射
            '2': 'city_list2'    # 长三角使用 city_list2 映射
        }

    def get_dataset_path(self, dataset_id: str) -> str:
        """获取数据集文件路径"""
        path = self.dataset_mapping.get(dataset_id)
        if path:
            return os.path.abspath(path)
        return None

    def get_city_list_index(self, city_id: int) -> int:
        """获取city_list中的索引位置"""
        return self.city_list_mapping.get(city_id, -1)

    def get_feature_index(self, feature_id: int) -> int:
        """获取feature列表中的索引位置"""
        return self.feature_mapping.get(feature_id, -1)

    def get_city_list2_index(self, city_id: int) -> int:
        """获取city_list2中的索引位置"""
        return self.city_list2_mapping.get(city_id, -1)

    def get_mapped_id(self, original_id: int, mapping_type: str = 'city_list') -> int:
        """获取映射后的ID"""
        if mapping_type == 'city_list':
            return self.get_city_list_index(original_id)
        elif mapping_type == 'feature':
            return self.get_feature_index(original_id)
        elif mapping_type == 'city_list2':
            return self.get_city_list2_index(original_id)
        else:
            return -1

    def get_city_mapping_type(self, dataset_id: str) -> str:
        """根据数据集ID获取对应的城市映射类型"""
        return self.dataset_city_mapping.get(dataset_id, 'city_list')

    def map_station_and_feature(self, dataset_id: str, station_id: int, feature_id: int) -> tuple:
        """映射站点ID和特征ID到对应的索引位置"""
        city_mapping_type = self.get_city_mapping_type(dataset_id)
        mapped_station = self.get_mapped_id(station_id, city_mapping_type)
        mapped_feature = self.get_mapped_id(feature_id, 'feature')
        return mapped_station, mapped_feature

    def is_valid_mapping(self, mapped_station: int, mapped_feature: int) -> bool:
        """检查映射结果是否有效"""
        return mapped_station != -1 and mapped_feature != -1