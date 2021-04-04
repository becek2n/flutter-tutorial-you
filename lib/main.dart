import 'package:flutter/material.dart';
import 'package:tutorial_flutter/models/MenuModel.dart';
import 'package:tutorial_flutter/views/CheckboxGroupView.dart';
import 'package:tutorial_flutter/views/GalleryPhotoZoomableView.dart';
import 'package:tutorial_flutter/views/BlocProductView.dart';
import 'package:tutorial_flutter/views/ProfileView.dart';
import 'package:tutorial_flutter/views/TrackingView.dart';
import 'package:tutorial_flutter/views/UploadPhotoLocalStorage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Tutorial Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: MyHomePage(title: "Tutorial Flutter",),
    );
    return materialApp;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MenuModel> menuModel = [];
  @override
  void initState() { 
    super.initState();
    menuModel.addAll({
      MenuModel(name: "Checkbox Group", view: CheckboxGroupView(), icon: Icon(Icons.check_box_outlined, size: 70,)),
      MenuModel(name: "Image Zoomable", view: GalleryPhotoZoomableView(), icon: Icon(Icons.image_search, size: 70)),
      // MenuModel(name: "Image Upload Local Storage", view: UploadPhotoLocalStorage(), icon: Icon(Icons.image_outlined, size: 70)),
      MenuModel(name: "Image Upload Local Storage", view: null, icon: Icon(Icons.image_outlined, size: 70)),
      MenuModel(name: "BLOC Fetch Complex JSON ", view: BlocProductView(), icon: Icon(Icons.settings_applications_outlined, size: 70)),
      // MenuModel(name: "BLOC Tracking Timeline ", view: TrackingView(), icon: Icon(Icons.settings_applications_outlined, size: 70)),
      MenuModel(name: "BLOC Profile Update", view: ProfileView(), icon: Icon(Icons.person, size: 70)),
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title!, style: TextStyle(fontSize: 30),)
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: GridView(
                // shrinkWrap: true,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List.generate(
                  menuModel.length,
                  (index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            menuModel[index].view! 
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
                                padding: EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("#" + (index + 1).toString(), 
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.orange)
                                      ),
                                      Divider(thickness: 3,),
                                      SizedBox(height: 10,),
                                      menuModel[index].icon!,
                                      SizedBox(height: 20,),
                                      Text(menuModel[index].name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                    ],
                                  ) 
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 0.7,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
