import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  static Future<bool> get isConnect async {
    final connect = await (Connectivity().checkConnectivity());
    if (connect == ConnectivityResult.mobile ||
        connect == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
