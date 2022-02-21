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

  static APIService<List<UserModel>> getAll(int pageIndex, int pageSize, String? search){
    var queryString = {
      'page': pageIndex.toString(),
      'size': pageSize.toString(),
      'search': search,
    };
    return APIService(
      url: Uri.http(baseAPIEcommerce, "/user", queryString),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var parsePagination = PaginationModel.fromJSON(dataJson.responsedata);
        var datas = parsePagination.datas as List;
        List<UserModel> users = datas.map((i) => UserModel.fromJSON(i)).toList();

        return users;
      }
    );
  } 

  static APIService<UserModel> create(dynamic body, File? file){
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
        var data = UserModel.fromJSON(dataJson.responsedata);

        return data;
      }
    );

  }

  static APIService<void> delete(int id){
    return APIService(
      url: Uri.http(baseAPIEcommerce, "/user/" + id.toString()),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);

        return null;
      }
    );
  } 
}