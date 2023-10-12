
import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  AppEnvironment.setupEnv(BuildType.dev);
  await Supabase.initialize(url: AppEnvironment.getEnv.getSupabaseUrl(), anonKey: AppEnvironment.getEnv.getSupabaseApiKey());

  final _supabase = Supabase.instance.client;
  final data = await _supabase.from('banner').select('*');
  print(data.toString());
}