// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:timelines/timelines.dart';
// import 'package:tutorial_flutter/models/ApplicationTracerModel.dart';

// class ApplicationTracerHistoryComponent extends StatelessWidget {
//   final List<InfoMonitoringModel>? monitorings; 
//   const ApplicationTracerHistoryComponent({Key? key, this.monitorings}) : super(key: 
//   key);

//   @override
//   Widget build(BuildContext context) {
//     final data = _data(monitorings!);
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               children: [
//                 Text(
//                   'History',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _DeliveryProcesses(processes: data.deliveryProcesses),
//         ],
//       ),
//     );
//   }
// }
// class _InnerTimeline extends StatelessWidget {
//   const _InnerTimeline({
//     required this.messages,
//   });

//   final List<_DeliveryMessage> messages;

//   @override
//   Widget build(BuildContext context) {
//     bool isEdgeIndex(int index) {
//       return index == 0 || index == messages.length + 1;
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: FixedTimeline.tileBuilder(
//         theme: TimelineTheme.of(context).copyWith(
//           nodePosition: 0,
//           connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
//                 thickness: 1.0,
//               ),
//           indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
//                 size: 10.0,
//                 position: 0.5,
//               ),
//         ),
//         builder: TimelineTileBuilder(
//           indicatorBuilder: (_, index) =>
//               !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
//           startConnectorBuilder: (_, index) => Connector.solidLine(),
//           endConnectorBuilder: (_, index) => Connector.solidLine(),
//           contentsBuilder: (_, index) {
//             if (isEdgeIndex(index)) {
//               return null;
//             }

//             return Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Text(messages[index - 1].toString()),
//             );
//           },
//           itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
//           nodeItemOverlapBuilder: (_, index) =>
//               isEdgeIndex(index) ? true : null,
//           itemCount: messages.length + 2,
//         ),
//       ),
//     );
//   }
// }

// class _DeliveryProcesses extends StatelessWidget {
//   const _DeliveryProcesses({Key? key, required this.processes})
//       : assert(processes != null),
//         super(key: key);

//   final List<_DeliveryProcess> processes;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//       style: TextStyle(
//         color: Color(0xff9b9b9b),
//         fontSize: 12.5,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: FixedTimeline.tileBuilder(
//           theme: TimelineThemeData(
//             nodePosition: 0,
//             color: Color(0xff989898),
//             indicatorTheme: IndicatorThemeData(
//               position: 0,
//               size: 20.0,
//             ),
//             connectorTheme: ConnectorThemeData(
//               thickness: 2.5,
//             ),
//           ),
//           builder: TimelineTileBuilder.connected(
//             connectionDirection: ConnectionDirection.before,
//             itemCount: processes.length,
//             contentsBuilder: (_, index) {
//               // if (processes[index].isCompleted) return null;
//               if (processes[index].status == 'Complete') return null;

//               return Padding(
//                 padding: EdgeInsets.only(left: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       processes[index].name,
//                       style: DefaultTextStyle.of(context).style.copyWith(
//                             fontSize: 18.0,
//                           ),
//                     ),
//                     _InnerTimeline(messages: processes[index].messages),
//                   ],
//                 ),
//               );
//             },
//             indicatorBuilder: (_, index) {
//               if (processes[index].status == 'Done' || processes[index].status == 'Complete') {
//                 return DotIndicator(
//                   color: Color(0xff66c97f),
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 12.0,
//                   ),
//                 );
//               }
//               else if (processes[index].status == 'Progress') {
//                 return OutlinedDotIndicator(
//                   color: Color(0xff2C9CDB),
//                   borderWidth: 12.0,
//                   backgroundColor: Color(0xffebcb62),
//                 );
//               }
//               else {
//                 return OutlinedDotIndicator(
//                   borderWidth: 2.5,
//                 );
//               }
//             },
//             connectorBuilder: (_, index, ___) => SolidLineConnector(
//               color: processes[index].status == 'Progress' ? Colors.grey : Color(0xff66c97f),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// _OrderInfo _data(List<InfoMonitoringModel> _monitorings) {
//   return _OrderInfo(
//     id: 1,
//     date: DateTime.now(),
//     driverInfo: _DriverInfo(
//       name: 'Philipe',
//       thumbnailUrl:
//           'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
//     ),
//     deliveryProcesses: [
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'TGLAPL').isNotEmpty) ? 'Done' : 'Progress',
//         'Terima & Input Aplikasi',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'VERAPL').isNotEmpty) ? 'Done' : 'Progress',
//         'Verifikasi Aplikasi',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'UWAREC').isNotEmpty) ? 'Done' : 'Progress',
//         'Terima U/W Awal',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'PRMINP').isNotEmpty) ? 'Done' : 'Progress',
//         'Input Premi',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'GENPOL').isNotEmpty) ? 'Done' : 'Progress',
//         'Generate Polis',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'VENCTK').isNotEmpty) ? 'Done' : 'Progress',
//         'Kirim Vendor Cetak',
//         messages: [
//           _DeliveryMessage('8:30am', 'Package received by driver'),
//           _DeliveryMessage('11:30am', 'Reached halfway mark'),
//         ],
//       ),
//       _DeliveryProcess(
//         (_monitorings != null && _monitorings.where((element) => element.trccod == 'VENCTK').isNotEmpty) ? 'Complete' : 'Not Complete',
//         'Selesai',
//         messages: [
//           _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
//           _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
//         ],
//       ),
//       // _DeliveryProcess.complete(),
//     ],
//   );
// } 

// class _OrderInfo {
//   const _OrderInfo({
//     required this.id,
//     required this.date,
//     required this.driverInfo,
//     required this.deliveryProcesses,
//   });

//   final int id;
//   final DateTime date;
//   final _DriverInfo driverInfo;
//   final List<_DeliveryProcess> deliveryProcesses;
// }

// class _DriverInfo {
//   const _DriverInfo({
//     required this.name,
//     this.thumbnailUrl,
//   });

//   final String name;
//   final String? thumbnailUrl;
// }

// class _DeliveryProcess {
//   const _DeliveryProcess(
//     this.status,
//     this.name, {
//     this.messages = const [],
//   });

//   final String name;
//   final String status;
//   final List<_DeliveryMessage> messages;

//   bool get isCompleted => name == 'Done';
// }

// class _DeliveryMessage {
//   const _DeliveryMessage(this.createdAt, this.message);

//   final String createdAt; // final DateTime createdAt;
//   final String message;

//   @override
//   String toString() {
//     return '$createdAt $message';
//   }
// }