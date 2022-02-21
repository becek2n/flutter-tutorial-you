import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tutorial_flutter/bloc/UserBloc.dart';
import 'package:tutorial_flutter/components/CircularLoading.dart';
import 'package:tutorial_flutter/components/InkButton.dart';
import 'package:tutorial_flutter/models/UserModel.dart';
import 'package:tutorial_flutter/views/Profile/ProfileForm.dart';
import 'package:tutorial_flutter/views/Profile/ProfileView.dart';

class ProfileListView extends StatefulWidget {
  ProfileListView({Key? key}) : super(key: key);

  @override
  _ProfileListViewState createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc()..add(GetAllEvent(page: 0, size: 5, search: "")),
      child: ProfileList()
    );
  }
}

class ProfileList extends StatefulWidget {
  ProfileList({Key? key}) : super(key: key);

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final nameController = TextEditingController(); 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<UserModel> listUser = [];
  bool isLoadMore = false;
  int pageIndex = 0;
  int deleteId = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoadMore = true;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text("List Profile", style: TextStyle( fontSize: 25, color: Colors.white),),
        backgroundColor: Color(0xFF1C85DD),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                    BlocProvider<UserBloc>(
                      create: (context) => UserBloc(),
                      child: ProfileForm(),
                    )
                  )
                );
                
              },
              child: Icon(Icons.person_add_rounded, size: 50,)
            ),
          )
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state){
          if(state is UserState && state.users != null){
            setState((){
              listUser.addAll(state.users!);
              isLoadMore = false;
            });
          }
          if(state is LoadingDeleteUser){
            WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
          }
          if(state is SuccessDeleteUser){
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success", "Delete Profile Success"));
            setState((){
              listUser.removeWhere((i) => i.id == deleteId);
            });
          }
        },
        buildWhen: (prev, curr){
          return curr is UserState && curr.users != null;
        },
        builder: (context, state){
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: listUser.length + 1,
            padding: EdgeInsets.only(top: 10, left: 10),
            itemBuilder: (context, index){
              return index >= listUser.length
                ? Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        context.read<UserBloc>().add(GetAllEvent(page: pageIndex + 1, size: 5, search: ""));
                        setState(() {
                          isLoadMore = true;
                          pageIndex +=1;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      elevation: 0.0,
                      padding: EdgeInsets.all(0.0),
                          child: Center(
                        child: (isLoadMore == true) ? CircularProgressIndicator(backgroundColor: Colors.orangeAccent,) 
                          : InkButton(text: "Load More"),
                        ),
                    ),
                  ),
                ) 
                : makeCard(context, listUser[index]);
            },
          ); 
        },
      ),
    );
  }

  Widget makeCard(BuildContext context,UserModel user) => Card(
    elevation: 5.0,
    color: Color(0xFF333366),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    margin: new EdgeInsets.symmetric(horizontal: 60.0, vertical: 2.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: makeListTile(context, user),
    ),
  );

  Widget makeListTile(BuildContext context, UserModel user){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView(id: user.id),));
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                  right: new BorderSide(width: 2.0, color: Colors.white24)
                )
              ),
              child: Icon(Icons.person_pin, color: Colors.orangeAccent, size: 80,)
            ),
            title: Text(user.firstName!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30,),
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            context.read<UserBloc>().add(DeleteEvent(id: user.id));
            setState((){
              deleteId = user.id;
            });
          },
        ),
      ],
    );
  }

}
