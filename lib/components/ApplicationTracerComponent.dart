import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/ApplicationTracerBloc.dart';
import 'package:tutorial_flutter/components/CircularLoading.dart';
import 'package:tutorial_flutter/components/DataItemComponent.dart';
import 'package:tutorial_flutter/models/ApplicationTracerModel.dart';
import 'package:tutorial_flutter/components/ApplcationTracerHistoryComponent.dart';

class ApplicationTracerComponent extends StatelessWidget {
  const ApplicationTracerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationTracerBloc, ApplicationTracerState>(
      listener: (BuildContext context, ApplicationTracerState state){
        
      },
        builder: (context, state){
          if(state is LoadingTracer){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularLoading(),
            ]
          );
        }else if(state is FailureProduct){
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('${state.error}'),
                ),
              ]
          );
        }
          if(state is ApplicationTracerState){
            if(state.application == null){
              return Column(
                children: [
                  CircularLoading(),
                ]
              ); 
            }else{
              ApplicationTracerModel application = state.application!;
              return ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Text(
                              'Main Info',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Card(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DetailItem(title: "No Aplikasi", value: application.aplksNmbr),
                                DetailItem(title: "Nama Lengkap", value: application.cstmFullName),
                                DetailItem(title: "Tgl Terima Aplikasi", value: application.aplksCreateOn == null ? "" : application.aplksCreateOn.toString()),
                                DetailItem(title: "Tgl Input Aplikasi", value: application.aplksCreateOn == null ? "" : application.aplksCreateOn.toString()),
                                DetailItem(title: "Tgl Input Premi", value: application.aplksCreateOn == null ? "" : application.aplksCreateOn.toString()),
                                DetailItem(title: "Tgl Verifikasi Aplikasi", value: application.aplksVrfyOn == null ? "" : application.aplksVrfyOn.toString()),
                                DetailItem(title: "Tgl Underwriting", value: application.underwriting == null ? "" : application.underwriting!.createOn.toString()),
                                DetailItem(title: "Catatan Underwriting", value: application.underwriting == null ? "" : application.underwriting!.risknoteNote.toString()),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Card(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(),
                                // ApplicationTracerHistoryComponent(monitorings: application.monitoring!),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                ],
              ); 
            }
          }else{
            return Column(
              children: [
                CircularLoading(),
              ]
            );
          }
        },
    );
  }
}


class LableInfo extends StatelessWidget {
  final String? header;
  final String? name;
  const LableInfo({Key? key, this.header, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Text(
                name!
              ),
            ),
          ),
          Divider(thickness: 2, color: Colors.grey),
        ],
      ),
    );
  }
}