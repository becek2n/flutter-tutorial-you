import 'package:bloc/bloc.dart';
import 'package:tutorial_flutter/models/PaymentTracerModel.dart';
import 'package:tutorial_flutter/repositories/PaymentTracerRepository.dart';
import 'package:tutorial_flutter/services/ApiService.dart';

class PaymentTracerBloc extends Bloc<PaymentTracerEvent, PaymentTracerState> {

  PaymentTracerBloc() : super(PaymentTracerState());

  @override
  Stream<PaymentTracerState> mapEventToState(PaymentTracerEvent event) async* {
    if (event is GetPaymentDetailEvent) {
      try{
        
        yield LoadingTracer();
        await Future.delayed(const Duration(seconds: 2));
        
        final PaymentTracerModel? data = await APIWeb().load(PaymentTracerRepository.getById(event.id));

        yield PaymentTracerState(payment: data);

      }catch(e){
        yield FailureTracer(e.toString());
      }
    }
  }
}

//event
abstract class PaymentTracerEvent {}

class GetPaymentDetailEvent extends PaymentTracerEvent {
  int? id;

  GetPaymentDetailEvent({this.id});
}


//state
class PaymentTracerState {
  final PaymentTracerModel? payment;

  const PaymentTracerState({this.payment});

  factory PaymentTracerState.initial() => PaymentTracerState();
}

class FailureTracer extends PaymentTracerState {
  final String error;

  FailureTracer(this.error);
}

class LoadingTracer extends PaymentTracerState {}
