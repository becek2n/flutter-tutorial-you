// import 'dart:io';

// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class UploadPhotoLocalStorage extends StatefulWidget {
//   UploadPhotoLocalStorage({Key? key}) : super(key: key);

//   @override
//   _UploadPhotoLocalStorageState createState() => _UploadPhotoLocalStorageState();
// }

// class _UploadPhotoLocalStorageState extends State<UploadPhotoLocalStorage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   List<File> imageStorage = [];
//   List<Asset> imagePicker = [];
//   String sError = 'No Error Dectected';

//   bool isLoad = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 0.1,
//         title: Center(child: Text('Upload Image Example', style: TextStyle(fontSize: 25),)),
//       ),
//       body: ListView(
//         children: [
//           Container(
//              child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     itemCount: imageStorage.length + 1,
//                     itemBuilder: (context, index){
//                       return index >= imageStorage.length
//                           ? Padding(
//                             padding: const EdgeInsets.only(left: 200, right: 200),
//                             child: InkWell(
//                               onTap: (){
//                                 loadImage();
//                               },
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50.0),
//                                   color: Colors.redAccent
//                                 ),
//                                 child: Center(
//                                   child: (isLoad == true) ? CircularProgressIndicator(backgroundColor: Colors.orangeAccent,) 
//                                     : Text("Load Image", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),),
//                                   ),
//                                 ),
//                             ),
//                           )
//                           :
//                         Container(child: Image.file(imageStorage[index]));
//                     }
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalForm(context);
//         },
//         tooltip: "Add",
//         child: Icon(Icons.add, size: 40, ),
//       ),
      
//     );
//   }

//   loadImage() async{

//     setState(() {
//       isLoad = true;
//     });

//     await Future.delayed(const Duration(seconds: 2));

//     Directory path = await getApplicationDocumentsDirectory();
//     setState(() {
//       for(int i = 1; i<3; i++){
//         String pathFile = path.path;
//         String fileName = '$pathFile/img-' + i.toString() + '.png';
//         File tempFile = File(fileName);
//         imageStorage.add(tempFile);
//       }
//       isLoad = false;
//     });


//     return true;
    
//   }

//   void showModalForm(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setStateModal ) {
//           return Container(
//             height: MediaQuery.of(context).size.height  * 0.5,
//             child: Padding(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height  * 0.03),
//               child: Column(
//                 children: [
//                   Center(
//                     child: Text("Upload Image", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
//                   ),
//                   Divider(thickness: 2,),
//                   SizedBox(height: 30,),
//                   RaisedButton(
//                     textColor: Colors.white,
//                     color: Colors.orangeAccent,
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("Pick images",),
//                     onPressed: () async {
//                         var res = await loadAssets();
//                         setStateModal(() {
//                           imagePicker = res;
//                           sError = "";
//                         });
//                     },
//                   ),
//                   Expanded(
//                     child: showImages(context),
//                   ),
//                   RaisedButton(
//                     onPressed: (){
//                       save();
//                     },
//                     textColor: Colors.white,
//                     color: Colors.red,
//                     padding: const EdgeInsets.all(8.0),
//                     child: new Text(
//                       "Save",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//           }
//         );
//       }
//     );
//   }

//   Future<List<Asset>> loadAssets() async {
//     List<Asset> resultList = [];

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 2,
//         enableCamera: true,
//         selectedAssets: imagePicker,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Image Example",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       sError = e.toString();
//     }

//     // if (!mounted) return null;

//     setState(() {
//       imagePicker = resultList;
//       sError = 'No Error Dectected';
//     });

//     return resultList;
//   }

//   void save() async{
//     int i = 1;
//     imagePicker.forEach((imageAsset) async {
//       final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
//       final file = await getImageFileFromAsset(filePath);
//       Directory path = await getApplicationDocumentsDirectory();
//       String pathUpload = path.path;
//       String fileName = '$pathUpload/img-' + i.toString() + '.png';
//       i++;
//       await file.copy(fileName); 
//     });

//     Navigator.of(context).pop();
//     _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text('Yay! Upload success!')));

//   }

//   getImageFileFromAsset(String path) async{
//     return File(path);
//   }

//   Widget showImages(BuildContext context) {
//     return GridView(
//       shrinkWrap: true,
//       padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
//       physics: const NeverScrollableScrollPhysics(),
//       scrollDirection: Axis.vertical,
//       children: List.generate(
//         imagePicker.length,
//         (index) {
//           Asset asset = imagePicker[index];
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8.0),
//                 bottomLeft: Radius.circular(8.0),
//                 bottomRight: Radius.circular(8.0),
//                 topRight: Radius.circular(8.0)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   offset: Offset(1.1, 1.1),
//                   blurRadius: 10.0),
//               ],
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
//                       child: AssetThumb(
//                         asset: asset,
//                         width: 300,
//                         height: 300,
//                       ),
//                     ),
//                   ],
//               ),
//             ),
//           );
//         },
//       ),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 6,
//         mainAxisSpacing: 10.0,
//         crossAxisSpacing: 15.0,
//         childAspectRatio: 1.0,
//       ),
//     );
//   }
// }