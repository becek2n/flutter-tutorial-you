import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_flutter/components/GalleryPhotoWrapper.dart';
import 'package:tutorial_flutter/components/GalleryThumbnail.dart';
import 'package:tutorial_flutter/models/GalleryItemModel.dart';
import 'package:tutorial_flutter/models/ProductModel.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel? productModel;
  ProductDetailView({Key? key, this.productModel}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  List<GalleryItemModel> galleries = [];
  int _current = 0;

  @override
  void initState() { 
    super.initState();
    widget.productModel!.productImageModel!.forEach((image) {
      galleries.add(GalleryItemModel(id: image.id, resource: image.photo, assetType: 'url', description: '', isSVG: false));
    });
  }  
    

  void _open(BuildContext context, final int index){
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => GalleryPhotoWrapper(
          galleries: galleries,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black
          ), 
          initalIndex: index,
          scrollDirection: Axis.horizontal,
        )
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product", style: TextStyle( fontSize: 30, color: Colors.white),),
        backgroundColor: Color(0xFF2BB64C),
        elevation: 1.0,
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: galleries.map((item) => Container(
              child: GalleryItemThumbnail(
                galleryItemModel: item,
                onTap: (){
                  _open(context, 0);
                },
              )
            )).toList(), 
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason){
                setState(() {
                  _current = index;
                });
              }
            )
          ),
          
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: galleries.map((url) {
                int index = galleries.indexOf(url);
                return Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.redAccent : Colors.grey
                    )
                  ),
                );
              }).toList(),
            ), 
          ),

          SizedBox(height: 20),
          
          Divider(thickness: 3, color: Colors.grey),
          
          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 30),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              color: Colors.white,
              elevation: 1.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Detail Info", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: Divider(thickness: 3, color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                    LableInfo(header: "Brand", name: widget.productModel!.productBaseRelaionModel!.brand!.name),
                    SizedBox(height: 10,),
                    LableInfo(header: "Category", name: widget.productModel!.productBaseRelaionModel!.category!.name),
                    SizedBox(height: 10,),
                    LableInfo(header: "Collection", name: widget.productModel!.productBaseRelaionModel!.collection!.name),
                    SizedBox(height: 10,),
                    LableInfo(header: "Name", name: widget.productModel!.name),
                    SizedBox(height: 10,),
                    LableInfo(header: "Description", name: widget.productModel!.description),
                  ],
                ),
              ),
            )
          ),
          
        ],
      ),
    );
  }
}

class LableInfo extends StatelessWidget {
  final String? header;
  final String? name;
  const LableInfo({Key? key, this.header, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Text(
                name!
              ),
            ),
          ),
          Divider(thickness: 2, color: Colors.grey),
        ],
      ),
    );
  }
}