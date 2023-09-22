import 'package:supabase_flutter/supabase_flutter.dart';

import '../api/supa_base/supa_base_configs.dart';

class InitDatabase {
  Future<void> initSupaBase() async {
    await Supabase.initialize(
      url: SupaBaseConfigs().url,
      anonKey: SupaBaseConfigs().anonKey,
    );
  }
}
