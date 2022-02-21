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

class PaginationModel{
  final int? totalItems;
  final int? totalPages;
  final int? currentPage;
  final dynamic? datas;

  PaginationModel({this.totalItems, this.totalPages, this.currentPage, this.datas});

  //mapping json
  factory PaginationModel.fromJSON(Map<String, dynamic> jsonMap){
    var list = jsonMap["datas"] as dynamic;
    return PaginationModel(
      totalItems: jsonMap["totalItems"],
      totalPages: jsonMap["totalPages"],
      currentPage: jsonMap["currentPage"],
      datas: list,
    );

  }
}