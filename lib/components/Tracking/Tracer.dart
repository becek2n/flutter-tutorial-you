import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_flutter/bloc/PaymentTracerBloc.dart';
import 'package:tutorial_flutter/components/CircularLoading.dart';
import 'package:tutorial_flutter/components/Tracking/Item.dart';
import 'package:tutorial_flutter/models/PaymentTracerModel.dart';
import 'package:tutorial_flutter/components/Tracking/Detail.dart';

class TracerComponent extends StatelessWidget {
  const TracerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentTracerBloc, PaymentTracerState>(
      listener: (BuildContext context, PaymentTracerState state){
        
      },
        builder: (context, state){
          if(state is LoadingTracer){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularLoading(),
            ]
          );
        }else if(state is FailureTracer){
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('${state.error}'),
                ),
              ]
          );
        }
          if(state is PaymentTracerState){
            if(state.payment == null){
              return Column(
                children: [
                  CircularLoading(),
                ]
              ); 
            }else{
              PaymentTracerModel payment = state.payment!;
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
                                DetailItem(title: "Payment ID", value: payment.id?.toString()),
                                DetailItem(title: "Name", value: payment.customerName),
                                DetailItem(title: "Address", value: payment.customerAddress),
                                DetailItem(title: "Total Item", value: payment.totalItem?.toString()),
                                DetailItem(title: "Total Amount", value: payment.amount?.toString()),

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
                                // PaymentTracerHistoryComponent(monitorings: application.monitoring!),
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