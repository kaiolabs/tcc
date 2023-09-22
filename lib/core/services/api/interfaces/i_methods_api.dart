import '../../../types/types.dart';

abstract interface class IMethodsApi {
  Future<List> get({
    required String table,
    List extras = const [],
    List<String> columns = const [],
    Json filter = const {},
    String order = '',
  }) async {
    return [];
  }

  Future<(bool status, String message)> post({
    required String table,
    required Json body,
    List extras = const [],
    String? filter,
  }) async {
    return (false, '');
  }

  Future<(bool status, String message)> put({
    required String table,
    List extras = const [],
    required Json body,
    String? filter,
  }) async {
    return (false, '');
  }

  Future<(bool status, String message)> delete({
    required String table,
    List extras = const [],
    String? filter,
  }) async {
    return (false, '');
  }
}
