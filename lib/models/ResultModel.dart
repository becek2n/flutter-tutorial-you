class ResultModel{
  final String? responsecode;
  final String? responsemessage;
  final dynamic responsedata;

  ResultModel({this.responsecode, this.responsemessage, this.responsedata});

  //mapping json data
  factory ResultModel.fromJSON(Map<String, dynamic> jsonMap){
    var list = jsonMap["responseData"] as dynamic;
    final data = ResultModel(
      responsecode: jsonMap["responseCode"].toString(),
      responsemessage: jsonMap["responseMessage"],
      responsedata: list
    );
    return data;
  }
}