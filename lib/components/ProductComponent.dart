import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/ProductBloc.dart';
import 'package:tutorial_flutter/components/CircularLoading.dart';
import 'package:tutorial_flutter/constants.dart';
import 'package:tutorial_flutter/models/ProductModel.dart';
import 'package:tutorial_flutter/views/ProductDetailView.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (BuildContext context, ProductState state){
        
      },
        builder: (context, state){
          if(state is LoadingProduct){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularLoading(),
            ]
          );
        }else if(state is FailureProduct){
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('${state.error}'),
                ),
              ]
          );
        }
          if(state is ProductState){
            if(state.products == null){
              return Column(
                children: [
                  CircularLoading(),
                ]
              ); 
            }else{
              List<ProductModel> productModel = state.products!;
              return GridView(
                // shrinkWrap: true,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List.generate(
                  productModel.length,
                  (index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new ProductDetailView(productModel: productModel[index]) 
                          )
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                                child: Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(productModel[index].thumbnail!.replaceAll("localhost:3001", baseAPIEcommerce)),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productModel[index].productBaseRelaionModel!.brand!.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    SizedBox(height:10),
                                    Text(productModel[index].name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                    SizedBox(height:10),
                                    Text(r"$ " + productModel[index].price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                  ],
                                ) 
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 0.8,
                ),
              );
               
            }
          }else{
            return Column(
              children: [
                CircularLoading(),
              ]
            );
          }
        },
    );
  }
}
