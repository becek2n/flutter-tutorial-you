import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tutorial_flutter/models/GalleryItemModel.dart';

class GalleryPhotoWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final Decoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initalIndex;
  final PageController pageController;
  final List<GalleryItemModel>? galleries;
  final Axis? scrollDirection;


  GalleryPhotoWrapper({Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    required this.initalIndex,
    this.galleries,
    this.scrollDirection
  }) : pageController = PageController(initialPage: initalIndex);

  @override
  State<StatefulWidget> createState(){
    return _GalleryPhotoWrapper();
  }
}

class _GalleryPhotoWrapper extends State<GalleryPhotoWrapper>{
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initalIndex;
  }

  void onPageChanged(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height
        ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: _buildItem,
            itemCount: widget.galleries!.length,
            loadingBuilder: widget.loadingBuilder,
            backgroundDecoration: widget.backgroundDecoration as BoxDecoration?,
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
            scrollDirection: widget.scrollDirection!,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.galleries![currentIndex].description!, 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),),
          
          )
        ],
      )
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index){
    final GalleryItemModel item = widget.galleries![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: ((item.assetType == "url") ? NetworkImage(item.resource!) : AssetImage(item.resource!)) as ImageProvider<Object>?,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.contained * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id!)

    );
  }
}