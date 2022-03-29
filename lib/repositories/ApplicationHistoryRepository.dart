import 'dart:convert';
import 'package:tutorial_flutter/models/ResultModel.dart';
import 'package:tutorial_flutter/models/ApplicationTracerModel.dart';
import 'package:tutorial_flutter/services/ApiService.dart';


class ApplicationTracerRepository{
  // static final baseUrl = '192.168.102.95';
  static final baseUrl = '172.20.10.2';

  static APIService<ApplicationTracerModel> getByNoApli(value){
    return APIService(
      url: Uri.http(baseUrl, "/Takaful-API/WebsmartTracer/" + value),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var data = ApplicationTracerModel.fromJSON(dataJson.responsedata);

        return data;
      }
    );
  }
}
