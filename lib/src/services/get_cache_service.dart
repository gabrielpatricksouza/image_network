import 'package:shared_preferences/shared_preferences.dart';

abstract class GetCache {
  Future cache(String key);
}

class AcessGetCache implements GetCache {
  final SharedPreferences prefs;
  AcessGetCache(this.prefs);

  @override
  Future cache(String key) async {
    try {
      return prefs.getString(key);
    } catch (error) {
      throw Exception('Erro na requisição [GET - Cache] : $error');
    }
  }
}
