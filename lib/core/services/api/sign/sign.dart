import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../log/log_pattern.dart';
import '../db/db.dart';
import '../methods/methods_api.dart';

class Sign {
  MethodsApi methods = MethodsApi();

  DB db = DB();
  LogPattern log = LogPattern();

  Future<(bool status, String result)> signUp({
    required String email,
    required String password,
    required String name,
    required String type,
    required String registration,
  }) async {
    SupabaseClient supabase = Supabase.instance.client;

    try {
      final checkEmail = await methods.get(table: db.users, filter: {'email': email});

      if (checkEmail.isNotEmpty) return (false, 'Email já cadastrado');

      try {
        try {
          bool status = false;
          String message = '';

          try {
            (status, message) = await methods.post(table: db.users, body: {
              'nome': name,
              'matricula': registration.replaceAll(RegExp(r'[^0-9]'), ''),
              'email': email,
              'type': type,
            });
            log.i('Cadastro realizado no banco de dados');

            await supabase.auth.signUp(password: password, email: email);

            log.i('Cadastro realizado no supabase');

            return (status, message);
          } on PostgrestException catch (e) {
            log.wtf('Erro ao cadastrar o usuário no banco de dados: $e');
            return (false, e.message);
          }
        } catch (e) {
          log.wtf('Erro ao cadastrar o usuário no banco de dados: $e');
          return (false, 'Erro ao cadastrar');
        }
      } on AuthException catch (state) {
        log.wtf('Erro ao cadastrar: ${state.message}');
        return (false, state.message);
      }
    } catch (e) {
      log.wtf('Erro buscar email: $e');
      return (false, 'Erro buscar email');
    }
  }

  Future<(bool status, String result)> signIn({required String email, required String password}) async {
    SupabaseClient supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithPassword(password: password, email: email);

      return (true, 'Login realizado com sucesso');
    } on AuthException catch (status) {
      log.wtf('Erro ao logar: $status');
      return (false, status.message);
    }
  }
}
