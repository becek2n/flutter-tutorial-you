import 'dart:convert';

import 'package:tutorial_flutter/constants.dart';
import 'package:tutorial_flutter/models/ProductModel.dart';
import 'package:tutorial_flutter/models/ResultModel.dart';
import 'package:tutorial_flutter/services/ApiService.dart';


class ProductRepository{
  static APIService<List<ProductModel>> load(endpoint){
    return APIService(
      url: Uri.http(baseAPIEcommerce, endpoint),
      // url: url,
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var productList = dataJson.responsedata as List;
        List<ProductModel> products = productList.map((i) => ProductModel.fromJSON(i)).toList();

        return products;
      }
    );
  }
}
