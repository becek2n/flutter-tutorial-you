import 'package:bloc/bloc.dart';
import 'package:tutorial_flutter/models/ApplicationTracerModel.dart';
import 'package:tutorial_flutter/repositories/ApplicationTracerRepository.dart';
import 'package:tutorial_flutter/services/ApiService.dart';

class ApplicationTracerBloc extends Bloc<ApplicationTracerEvent, ApplicationTracerState> {

  ApplicationTracerBloc() : super(ApplicationTracerState());

  @override
  Stream<ApplicationTracerState> mapEventToState(ApplicationTracerEvent event) async* {
    if (event is GetApplicationDetailEvent) {
      try{
        
        yield LoadingTracer();
        await Future.delayed(const Duration(seconds: 2));
        
        final data = await APIWeb().load(ApplicationTracerRepository.getByNoApli(event.noapli));

        yield ApplicationTracerState(application: data);

      }catch(e){
        yield FailureProduct(e.toString());
      }
    }
  }
}

//event
abstract class ApplicationTracerEvent {}

class GetApplicationDetailEvent extends ApplicationTracerEvent {
  String? noapli;

  GetApplicationDetailEvent({this.noapli});
}


//state
class ApplicationTracerState {
  final ApplicationTracerModel? application;

  const ApplicationTracerState({this.application});

  factory ApplicationTracerState.initial() => ApplicationTracerState();
}

class FailureProduct extends ApplicationTracerState {
  final String error;

  FailureProduct(this.error);
}

class LoadingTracer extends ApplicationTracerState {}
