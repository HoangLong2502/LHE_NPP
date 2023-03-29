import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';

class GroupService {
  final _dio = BaseDio();

  Future<Map> getAll() async {
    try {
      var system_key = 'NPP';
      var res = await _dio.dio().get('${Api.group}?system_key=$system_key');
      return res.data;
    } catch (e) {
      throw Exception('err : $e');
    }
  }

  Future<Map> create(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio().post(Api.group_create, data: payload);
      return res.data;
    } catch (e) {
      throw Exception('err : $e');
    }
  }

  Future<Map> delete(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio().post(Api.group_create, data: payload);
      return {
        'data' : 200,
        'message' : 'Success',
      };
    } catch (e) {
      throw Exception('err : $e');
    }
  }
}