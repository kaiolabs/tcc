import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../log/log_pattern.dart';
import '../../../types/types.dart';
import '../db/db.dart';
import '../interfaces/i_methods_api.dart';

class MethodsApi implements IMethodsApi {
  DB db = DB();
  @override
  Future<(bool status, String message)> delete({required String table, List extras = const [], String? filter}) async {
    SupabaseClient supabase = Supabase.instance.client;
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List> get(
      {required String table, List extras = const [], List<String> columns = const [], Json filter = const {}, String order = ''}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(table).select().eq(filter.keys.first, filter.values.first);

      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela $table: $e');
      return [];
    }
  }

  @override
  Future<(bool status, String message)> post({required String table, required Json body, List extras = const [], String? filter}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      await supabase.from(table).insert(body);
      return (true, 'Sucesso');
    } on PostgrestException catch (state, e) {
      LogPattern().wtf('Error no post da tabela $table: $e');
      return (false, state.message);
    }
  }

  @override
  Future<(bool status, String message)> put({required String table, List extras = const [], required Json body, String? filter}) async {
    SupabaseClient supabase = Supabase.instance.client;
    // TODO: implement put
    throw UnimplementedError();
  }
}
