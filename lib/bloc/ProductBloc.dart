import 'package:bloc/bloc.dart';
import 'package:tutorial_flutter/models/ProductModel.dart';
import 'package:tutorial_flutter/repositories/ProductRepository.dart';
import 'package:tutorial_flutter/services/ApiService.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is GetCategoryEvent) {
      try{
        
        yield LoadingProduct();
        await Future.delayed(const Duration(seconds: 2));
        
        final data = await APIWeb().load(ProductRepository.load('product/category/' + event.name!));

        yield ProductState(products: data);

      }catch(e){
        yield FailureProduct(e.toString());
      }
    }
  }
}

//event
abstract class ProductEvent {}

class GetCategoryEvent extends ProductEvent {
  String? name;

  GetCategoryEvent({this.name});
}


//state
class ProductState {
  final List<ProductModel>? products;

  const ProductState({this.products});

  factory ProductState.initial() => ProductState();
}

class FailureProduct extends ProductState {
  final String error;

  FailureProduct(this.error);
}

class LoadingProduct extends ProductState {}
