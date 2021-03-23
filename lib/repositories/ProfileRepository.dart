import 'dart:convert';
import 'package:tutorial_flutter/constants.dart';
import 'package:tutorial_flutter/models/ResultModel.dart';
import 'package:tutorial_flutter/models/ApplicationTracerModel.dart';
import 'package:tutorial_flutter/services/ApiService.dart';


class ProfileRepository{

  static APIService<ApplicationTracerModel> getId(id){
    return APIService(
      url: Uri.http(baseAPIEcommerce, "/user/" + id),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var data = ApplicationTracerModel.fromJSON(dataJson.responsedata);

        return data;
      }
    );
  }
}
