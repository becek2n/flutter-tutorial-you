import 'dart:convert';
import 'package:tutorial_flutter/models/PaymentTracerModel.dart';
import 'package:tutorial_flutter/models/ResultModel.dart';
import 'package:tutorial_flutter/services/ApiService.dart';


class PaymentTracerRepository{
  static final baseUrl = '192.168.102.231';//'192.168.95.2';

  static APIService<PaymentTracerModel> getById(value){
    return APIService(
      url: Uri.http(baseUrl, "/tutorial/deliverytracer/" + value.toString()),
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = ResultModel.fromJSON(parsed);
        var data = PaymentTracerModel.fromJSON(dataJson.responsedata);

        return data;
      }
    );
  }
}
