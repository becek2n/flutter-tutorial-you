import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_flutter/components/GalleryPhotoWrapper.dart';
import 'package:tutorial_flutter/components/GalleryThumbnail.dart';
import 'package:tutorial_flutter/models/GalleryItemModel.dart';
class GalleryPhotoZoomableView extends StatefulWidget {
  GalleryPhotoZoomableView({Key? key}) : super(key: key);

  @override
  _GalleryPhotoZoomableViewState createState() => _GalleryPhotoZoomableViewState();
}

class _GalleryPhotoZoomableViewState extends State<GalleryPhotoZoomableView> {
  bool verticalGallery = false;

  List<GalleryItemModel> galleries = [
    GalleryItemModel(id: 1, resource: "assets/mountain.jpg", description: "Image Mountain Default", isSVG: false),
    GalleryItemModel(id: 2, resource: "assets/mountain1.jpg", description: "Image Mountain 1", isSVG: false),
    GalleryItemModel(id: 3, resource: "assets/mountain2.jpg", description: "Image Mountain 2", isSVG: false),
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery Photo Zoomable"),
      ),
      backgroundColor: Colors.white,
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
                    Text("Name", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          "Name bla lab asldjal asjdalskdjasdjaasudiyasida oasudoiasdasdas sa"
                        ),
                      ),
                    ),
                    Divider(thickness: 2, color: Colors.grey),
                    SizedBox(height: 10,),
                    Text("Description", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          "Name bla lab asldjal asjdalskdjasdjaasudiyasida oasudoiasdasdas sa"
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
         ],
       ),
    );
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
}