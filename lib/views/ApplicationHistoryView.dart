import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/ApplicationHistoryBloc.dart';
import 'package:tutorial_flutter/components/ApplicationHistory/ApplicationTracerComponent.dart';

class ApplicationHistoryView extends StatefulWidget {
  ApplicationHistoryView({Key? key}) : super(key: key);

  @override
  _ApplicationHistoryViewState createState() => _ApplicationHistoryViewState();
}

class _ApplicationHistoryViewState extends State<ApplicationHistoryView> {
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


