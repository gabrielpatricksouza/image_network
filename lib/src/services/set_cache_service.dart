import 'package:shared_preferences/shared_preferences.dart';

abstract class SetCache {
  Future<bool> cache(String key, dynamic value);
}

class AcessSetCache implements SetCache {
  final SharedPreferences prefs;
  AcessSetCache(this.prefs);

  @override
  Future<bool> cache(String key, value) async {
    try {
      return prefs.setString(key, value);
    } catch (error) {
      throw Exception('Erro na requisição [SET - Cache] : $error');
    }
  }
}
