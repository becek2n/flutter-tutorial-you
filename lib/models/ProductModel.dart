class ProductModel{
  final int? id;
  final int? productBaseRelationId;
  final String? name;
  final String? description;
  final double? price;
  final double? discount;
  final String? thumbnail;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductImageModel>? productImageModel;
  final ProductBaseRelaionModel? productBaseRelaionModel;

  ProductModel({this.id, this.productBaseRelationId, this.name, this.description, 
    this.price, this.discount, this.thumbnail, 
    this.createdAt, this.updatedAt,
    this.productImageModel,
    this.productBaseRelaionModel
  });

  //mapping json data
  factory ProductModel.fromJSON(Map<String, dynamic> jsonMap){
    
    var price = double.parse(jsonMap["price"] ?? 0.0 as String);
    var discount = jsonMap["discount"] ?? 0.0;
    
    var images = jsonMap["ProductImages"] as List;
    List<ProductImageModel> listImages = images.map((i) => ProductImageModel.fromJSON(i)).toList();
    
    ProductBaseRelaionModel productBase = ProductBaseRelaionModel.fromJSON(jsonMap["ProductBaseRelation"]);
    
    final data = ProductModel(
      id: jsonMap["id"],
      productBaseRelationId: jsonMap["productBaseRelationId"],
      name: jsonMap["name"],
      description: jsonMap["description"],
      price: price,
      discount: discount,
      thumbnail: jsonMap["thumbnail"],
      createdAt: DateTime.parse(jsonMap["createdAt"]),
      updatedAt: DateTime.parse(jsonMap["updatedAt"]),
      productImageModel: listImages,
      productBaseRelaionModel: productBase
    );
    return data;
  }
}

class ProductImageModel{
  final int? id;
  final int? productId;
  final String? photo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductImageModel({this.id, this.productId, this.photo, this.createdAt, this.updatedAt});

  factory ProductImageModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = ProductImageModel(
      id: jsonMap["id"],
      productId: jsonMap["productId"],
      photo: jsonMap["photo"],
      createdAt: DateTime.parse(jsonMap["createdAt"]),
      updatedAt: DateTime.parse(jsonMap["updatedAt"]),
    );
    return data;
  }
}

class ProductBaseRelaionModel{
  final int? id;
  final int? brandId;
  final int? categoryId;
  final int? collectionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BrandModel? brand;
  final CategoryModel? category;
  final CollectionModel? collection;

  ProductBaseRelaionModel({this.id, this.brandId, this.categoryId, this.collectionId, 
    this.createdAt, this.updatedAt, 
    this.brand, this.category, this.collection
  });

  factory ProductBaseRelaionModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = ProductBaseRelaionModel(
      id: jsonMap["id"],
      brandId: jsonMap["brandId"],
      categoryId: jsonMap["categoryId"],
      collectionId: jsonMap["collectionId"],
      createdAt: DateTime.parse(jsonMap["createdAt"]),
      updatedAt: DateTime.parse(jsonMap["updatedAt"]),
      brand: BrandModel.fromJSON(jsonMap['Brand']),
      category: CategoryModel.fromJSON(jsonMap['Category']),
      collection: CollectionModel.fromJSON(jsonMap['Collection']),
    );
    return data;
  }
}


class BrandModel {
  final int? id;
  final String? name;
  final String? thumbnail;

  BrandModel({this.id, this.name, this.thumbnail});

  factory BrandModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = BrandModel(
      id: jsonMap["id"],
      name: jsonMap["name"],
      thumbnail: jsonMap["thumbnail"],
    );
    return data;
  }
}

class CategoryModel {
  final int? id;
  final String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = CategoryModel(
      id: jsonMap["id"],
      name: jsonMap["name"],
    );
    return data;
  }
}

class CollectionModel {
  final int? id;
  final String? name;

  CollectionModel({this.id, this.name});

  factory CollectionModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = CollectionModel(
      id: jsonMap["id"],
      name: jsonMap["name"],
    );
    return data;
  }
}
