import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial_flutter/bloc/UserBloc.dart';
import 'package:tutorial_flutter/components/CircularLoading.dart';
import 'package:tutorial_flutter/components/DataItemComponent.dart';
import 'package:tutorial_flutter/components/InkButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? _image;
  String userBlank = "https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png";
  final picker = ImagePicker();
  
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text("Add Profile", style: TextStyle( fontSize: 25, color: Colors.white),),
        backgroundColor: Color(0xFF1C85DD),
        elevation: 0.0,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state){
          if(state is LoadingUser){
            WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
          }else if(state is SuccessSaveUser){
            clearForm();
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success", "Add Profile Success"));
          }else if(state is FailureUser){
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error", state.error));
          }
        },
        builder: (context, state){
          return Container(
            child:  Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 450,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.redAccent, Colors.pinkAccent]
                            )
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: Colors.grey[300],
                                    image: DecorationImage(
                                      image: (_image != null) ? FileImage(_image!) : NetworkImage(userBlank) as ImageProvider ,
                                      fit: BoxFit.cover
                                    )
                                  ),
                                  child: InkWell(
                                    child: Icon(Icons.camera_alt_outlined, size: 100, color: Colors.grey,),
                                    onTap: (){
                                      getImage();
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),

                              ],
                            ),
                          ),
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
                  DetailItemEditComponent(
                    title: "First Name", 
                    widget: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a first name';
                        }
                        return null;
                      },
                      controller: firstNameController,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        hintText: "First Name",
                      ),
                    ),
                  ),

                  DetailItemEditComponent(
                    title: "Last Name", 
                    widget: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a last name';
                        }
                        return null;
                      },
                      controller: lastNameController,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        hintText: "Last Name",
                      ),
                    ),
                  ),
                  DetailItemEditComponent(
                    title: "Email", 
                    widget: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1),
                        ),
                        hintText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              elevation: 0.0,
                              padding: EdgeInsets.all(0.0),
                              child: InkButton(text: "Save"),
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {
                                  context.read<UserBloc>().add(SaveEvent(id: 0, 
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    file: _image
                                    )
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          );
     
        },
      )
      
    );
  }

  void clearForm(){
    firstNameController.text = "";
    lastNameController.text = "";
    emailController.text = "";
    _image = null;
  }
}

