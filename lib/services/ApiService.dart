import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutorial_flutter/constants.dart';

class APIService<T> {
  final String url;
  final dynamic body;
  T Function(http.Response response) parse;
  APIService({this.url, this.body, this.parse});  
}

class APIWeb{ 
  Future<T> load<T>(APIService<T> resource) async {
      final response = await http.get(baseAPI + resource.url);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception(response.statusCode);
      }
  }

  Future<T> post<T>(APIService<T> resource) async {
    Map<String, String>  headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(baseAPI + resource.url, body: jsonEncode(resource.body), headers: headers);
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception(response.statusCode);
    }
  }

}