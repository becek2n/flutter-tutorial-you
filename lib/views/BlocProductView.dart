import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/ProductBloc.dart';
import 'package:tutorial_flutter/components/ProductComponent.dart';

class BlocProductView extends StatefulWidget {
  BlocProductView({Key? key}) : super(key: key);

  @override
  _BlocProductViewState createState() => _BlocProductViewState();
}

class _BlocProductViewState extends State<BlocProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product", style: TextStyle( fontSize: 30, color: Colors.white),),
        backgroundColor: Color(0xFF2BB64C),
        elevation: 1.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.search, size: 40,),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Icon(Icons.shopping_bag_outlined, size: 40,),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: BlocProvider<ProductBloc>(
              create: (context) => ProductBloc()..add(GetCategoryEvent(name: "Fashion")),
              child: ProductComponent(),
            ),
          ),
        ],
      ),
    );
  }
}