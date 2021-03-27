import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Networking(this.host, this.path, this.key);
  final String host,path,key;

  Future getData() async {
    http.Response response = await http
        .get(Uri.https(host, path, { "api_key" : key }));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
