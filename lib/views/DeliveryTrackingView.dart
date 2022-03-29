import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/PaymentTracerBloc.dart';
import 'package:tutorial_flutter/components/Tracking/Tracer.dart';

class DeliveryTrackingView extends StatefulWidget {
  DeliveryTrackingView({Key? key}) : super(key: key);

  @override
  _DeliveryTrackingState createState() => _DeliveryTrackingState();
}

class _DeliveryTrackingState extends State<DeliveryTrackingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Delivery Tracking'),
      ),
      body: BlocProvider<PaymentTracerBloc>(
        create: (context) => PaymentTracerBloc()..add(GetPaymentDetailEvent(id: 1)),
        child: TracerComponent(),
      )
    );
  }
}


