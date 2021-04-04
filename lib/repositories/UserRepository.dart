import 'dart:convert';
import 'dart:io';

import 'package:tutorial_flutter/constants.dart';
import 'package:tutorial_flutter/models/ResultModel.dart';
import 'package:tutorial_flutter/models/UserModel.dart';
import 'package:tutorial_flutter/services/ApiService.dart';

class UserRepository{
  static APIService<UserModel> getId(int id){
    return APIService(
      url: Uri.http(baseAPIEcommerce, "/user/" + id.toString()),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var data = UserModel.fromJSON(dataJson.responsedata);

        return data;
      }
    );
  } 

  static APIService<int> update(dynamic body, File? file){
    List<File> _files = [];

    if(file != null){
      _files.add(file);
    }

    return APIService(
      url: Uri.http(baseAPIEcommerce, "/user"),
      body: body,
      files: _files,
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var data = dataJson.responsedata;

        return data;
      }
    );

  }
}