import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/modules/home/models/nota.dart';

import '../../../log/log_pattern.dart';
import '../../../types/types.dart';
import '../db/db.dart';
import '../interfaces/i_methods_api.dart';

class MethodsApi implements IMethodsApi {
  DB db = DB();
  @override
  Future<(bool status, String message)> delete({required String table, List extras = const [], String? filter}) async {
    // SupabaseClient supabase = Supabase.instance.client;

    throw UnimplementedError();
  }

  @override
  Future<List> get(
      {required String table, List extras = const [], List<String> columns = const [], Json filter = const {}, String order = ''}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(table).select().eq(filter.keys.first, filter.values.first).eq(filter.keys.last, filter.values.last);

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
  Future<(bool status, String message)> put(
      {required String table, List extras = const [], required Json body, Json filter = const {}}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      await supabase.from(table).update(body).eq(filter.keys.first, filter.values.first).eq(filter.keys.last, filter.values.last);
      return (true, 'Sucesso');
    } on PostgrestException catch (state, e) {
      LogPattern().wtf('Error no put da tabela $table: $e');
      return (false, state.message);
    }
  }

  // get banca
  Future<List> getBanca() async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.users).select().eq('type', 'Professor');
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.users}: $e');
      return [];
    }
  }

  // get tccs do usuario
  Future<List> getTccs(String email) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.tcc).select().eq('aluno', email).order('data_cadastro', ascending: true);
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.tcc}: $e');
      return [];
    }
  }

  // get tccs que o cordenador faz parte
  Future<List> getTccsCordenador(String email) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.tcc).select().eq('cordenador', email).order('data_cadastro', ascending: true);
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.tcc}: $e');
      return [];
    }
  }

  // get tccs que o avaliador faz parte
  Future<List> getTccsAvaliacao(String email) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.tcc).select().like('id_avaliadores', '%$email%').order('data_cadastro', ascending: true);
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.tcc}: $e');
      return [];
    }
  }

  Future<List> getTcc(String id) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.tcc).select().eq('id', id);
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.tcc}: $e');
      return [];
    }
  }

  Future<(bool status, String message)> addReuniao({required String idTcc, required String dataMeet, required String descricao}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      await supabase.from(db.meetings).insert({
        'id_tcc': idTcc,
        'id_user': supabase.auth.currentUser!.email,
        'data_meet': dataMeet,
        'descricao': descricao,
        'permissoes': 'RO',
      });
      return (true, 'Sucesso na inserção da reunião de tcc');
    } on PostgrestException catch (state, e) {
      LogPattern().wtf('Error no post da tabela ${db.meetings}: $e');
      return (false, state.message);
    }
  }

  Future<(bool status, String message)> addAvaliacao({required Nota nota}) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      await supabase.from(db.notas).insert({
        'comentario': nota.comentario,
        'nota_introducao': nota.notaIntroducao,
        'nota_revisao_bibliografica_p1': nota.notaRevisaoBibliograficaP1,
        'nota_revisao_bibliografica_p2': nota.notaRevisaoBibliograficaP2,
        'nota_orientacao_metodologica_p1': nota.notaOrientacaoMetodologicaP1,
        'nota_orientacao_metodologica_p2': nota.notaOrientacaoMetodologicaP2,
        'nota_definicao_objetivos': nota.notaDefinicaoObjetivos,
        'id_tcc': nota.idTcc,
        'id_autor': supabase.auth.currentUser!.email,
        'data_inclusao': nota.dataInclusao,
        'chamada': '1',
      });
      return (true, 'Sucesso na inserção da avaliação, muito obrigado!');
    } on PostgrestException catch (state, e) {
      LogPattern().wtf('Error no post da tabela ${db.notas}: $e');
      return (false, state.message);
    }
  }

  // getReunioes
  Future<List> getReunioes(String email) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.meetings).select().eq('id_user', email).order('data_meet', ascending: true);
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.meetings}: $e');
      return [];
    }
  }

  Future<(bool status, String message)> checkIfUserAlreadyGaveANote(String idTcc) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      List res = await supabase.from(db.notas).select().eq('id_tcc', idTcc).eq('id_autor', supabase.auth.currentUser!.email);
      return (res.isNotEmpty, 'Você já avaliou esse TCC anteriormente!');
    } on PostgrestException catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.notas}: $e');
      return (false, e.message);
    }
  }

  // vai pegar o id do cordeandor e vai buscar na tabela notas pela nota que o aluno tirou
  Future<List> getNotaOrientador(String idTcc, String idOrientador) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.notas).select().eq('id_tcc', idTcc).eq('id_autor', idOrientador).eq('chamada', '1');
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.notas}: $e');
      return [];
    }
  }

  // vai pegar o id do cordeandor e vai buscar na tabela notas pela nota que o aluno tirou

  Future<List> getNotaBanca1(String idTcc, String idBanca1) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.notas).select().eq('id_tcc', idTcc).eq('id_autor', idBanca1).eq('chamada', '1');
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.notas}: $e');
      return [];
    }
  }

  // vai pegar o id do cordeandor e vai buscar na tabela notas pela nota que o aluno tirou

  Future<List> getNotaBanca2(String idTcc, String idBanca2) async {
    SupabaseClient supabase = Supabase.instance.client;
    try {
      final res = await supabase.from(db.notas).select().eq('id_tcc', idTcc).eq('id_autor', idBanca2).eq('chamada', '1');
      return res;
    } catch (e) {
      LogPattern().wtf('Error no get da tabela ${db.notas}: $e');
      return [];
    }
  }
}
