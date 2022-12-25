// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:greentracker/models/location.dart';

// class TransportModel extends StatelessWidget {
//   const TransportModel(
//       {super.key,
//       this.failWidget =
//           const Center(child: Text('No transport assigned to you currently.')),
//       required this.successWidget});
//   final Widget successWidget;
//   final Widget failWidget;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getTransportData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               TransportAPI transportAPI = snapshot.data as TransportAPI;
//               if (transportAPI.status == 200) {
//                 TransportData transportData =
//                     transportAPI.transportData as TransportData;
//                 List<ListTrasport> list = transportData.list;
//                 return SingleChildScrollView(
//                   child: successWidget,
//                 );
//               } else {
//                 return failWidget;
//               }
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }
// }
