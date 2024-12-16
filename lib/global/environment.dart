import 'dart:io';

class Environment {
  //OFC
  static String apiUrl = 'http://172.16.3.32:3000/api';
  /*static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://192.168.0.220:3000/api';*/

  static String socketUrl = 'http://172.16.3.32:3000';
  /*static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://192.168.0.220:3000';*/
}
