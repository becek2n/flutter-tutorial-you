import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/models/UserModel.dart';
import 'package:tutorial_flutter/repositories/UserRepository.dart';
import 'package:tutorial_flutter/services/ApiService.dart';

class UserBloc extends  Bloc<UserEvent, UserState>{

  UserBloc() : super(UserState());
  
  @override 
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is GetIdEvent){
      try{
        yield LoadingUser();
        await Future.delayed(const Duration(seconds: 1));
        
        final data = await APIWeb().load(UserRepository.getId(event.id));

        yield UserState(user: data);

      }catch(ex){
        yield FailureUser(ex.toString());
      }
    }

    if(event is SaveEvent){
      try{
        yield LoadingUser();
        await Future.delayed(const Duration(seconds: 1));
        dynamic formData;

        formData = {
          'id': event.id,
          'firstName': event.firstName,
          'lastName': event.lastName,
        };

        await APIWeb().putFormData(UserRepository.update(formData, event.file));

        yield SuccessSaveUser();        
      }catch(ex){
        yield FailureUser(ex.toString());
      }
    }
  }
}
//event
abstract class UserEvent {}

class GetIdEvent extends UserEvent{
  int id;

  GetIdEvent({required this.id});
}

class SaveEvent extends UserEvent{
  int id;
  String? firstName;
  String? lastName;
  File? file;
  SaveEvent({required this.id, this.firstName, this.lastName, this.file});
}

//state
class UserState{
  final UserModel? user;
  const UserState({this.user});

  factory UserState.initial() => UserState();
}

class LoadingUser extends UserState  {}
class SuccessSaveUser extends UserState  {}
class FailureUser extends UserState {
  String error;
  FailureUser(this.error);
}
