import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/ApplicationTracerBloc.dart';
import 'package:tutorial_flutter/components/ApplicationTracerComponent.dart';

class TrackingView extends StatefulWidget {
  TrackingView({Key? key}) : super(key: key);

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Application Tracer'),
      ),
      body: BlocProvider<ApplicationTracerBloc>(
        create: (context) => ApplicationTracerBloc()..add(GetApplicationDetailEvent(noapli: "DC00473")),
        child: ApplicationTracerComponent(),
      )
    );
  }
}


