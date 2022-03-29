class PaymentTracerModel{
  final int? id;
  final String? customerName;
  final String? customerAddress;
  final int? totalItem;
  final double? amount;
  final List<OrderStatusModel>? orderStatuses;

  PaymentTracerModel({this.id, this.customerName, this.customerAddress, this.totalItem, this.amount, this.orderStatuses});

  factory PaymentTracerModel.fromJSON(Map<String, dynamic> jsonMap){
    
    var orders = jsonMap["orderStatuses"] as List;
    List<OrderStatusModel> objOrderStatuses = orders.map((i) => OrderStatusModel.fromJSON(i)).toList();
    final data = PaymentTracerModel(
      id: int.parse(jsonMap["id"].toString()),
      customerName: jsonMap["customerName"],
      customerAddress: jsonMap["customerAddress"],
      totalItem: int.parse(jsonMap["totalItem"].toString()),
      amount: double.parse(jsonMap["amount"].toString()),
      orderStatuses: objOrderStatuses,
    );
    return data;
  }
}

class OrderStatusModel{
  final int? id;
  final int? orderId;
  final int? stepNumber;
  final String? statusName;
  final String? description;
  final DateTime? dateCreated;

  OrderStatusModel({this.id, this.orderId, this.stepNumber, this.statusName, this.description, this.dateCreated});

  factory OrderStatusModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = OrderStatusModel(
      id: int.parse(jsonMap["id"].toString()),
      orderId: int.parse(jsonMap["orderId"].toString()),
      stepNumber: int.parse(jsonMap["stepNumber"].toString()),
      statusName: jsonMap["statusName"],
      description: jsonMap["description"],
      dateCreated: DateTime.parse(jsonMap["dateCreated"]),
    );
    return data;
  }
}