import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:tutorial_flutter/components/DataItemComponent.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Asset> imagePicker = [];
  String sError = 'No Error Dectected';

  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Profile", style: TextStyle( fontSize: 25, color: Colors.white),),
        backgroundColor: Color(0xFF2BB64C),
        elevation: 1.0,
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.grey[300],
                      image: DecorationImage(
                          image: AssetImage("assets/user.png") ,
                          fit: BoxFit.fill
                        )
                    ),
                    child: InkWell(
                      child: 
                        Icon(Icons.camera_alt_outlined, size: 100, color: Colors.white,),
                      onTap: (){
                        loadAssets();
                      },
                    ) 
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Center(
                      child: Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize:50),
                      ),
                    ),
                    trailing: InkWell(
                      onTap: (){
                        
                        setState(() {
                          _editMode = true;
                        });
                      },
                      child: Icon(Icons.edit_location_outlined, size: 50, color: Colors.black,),
                    ) 
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Info Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  DetailItem(
                    title: "First Name",
                    value: "",
                  ),
                  DetailItem(
                    title: "Last Name",
                    value: "",
                  ),
                  DetailItem(
                    title: "Email",
                    value: "",
                  ),
                  
                  Divider(),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (_editMode == true) ? Container() 
              :
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: RaisedButton(
                        onPressed: (){},
                        child: Text(
                              "Cancel",
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: RaisedButton(
                        onPressed: (){},
                        child: Text(
                              "LOGOUT",
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Future<List<Asset>?> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        selectedAssets: imagePicker,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Image Example",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      sError = e.toString();
    }

    if (!mounted) return null;

    setState(() {
      imagePicker = resultList;
      sError = 'No Error Dectected';
    });

    return resultList;
  }

  
}