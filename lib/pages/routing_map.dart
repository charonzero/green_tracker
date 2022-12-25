import 'package:flutter/material.dart';
import 'package:greentracker/models/location.dart';
import 'package:greentracker/models/GoogleMapRender.dart';

class RoutingMap extends StatefulWidget {
  const RoutingMap({super.key});

  @override
  _RoutingMapState createState() => _RoutingMapState();
}

class _RoutingMapState extends State<RoutingMap> {
  // double? latitute;
  // double? longitude;
  // static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
            future: getTransportData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  TransportAPI transportAPI = snapshot.data as TransportAPI;
                  if (transportAPI.status == 200) {
                    TransportData transportData =
                        transportAPI.transportData as TransportData;
                    List<ListTrasport> list = transportData.list;
                    return GoogleMapRender(
                      startingLocation: transportData.startingLocation,
                      maphash: transportData.maphash,
                      list: list,
                    );
                  } else {
                    return const Center(
                      child: Text('No transport assigned to you currently.'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
