import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/models/location.dart';
import 'package:greentracker/models/GoogleMapRender.dart';

class RoutingMap extends StatefulWidget {
  const RoutingMap({super.key});

  @override
  _RoutingMapState createState() => _RoutingMapState();
}

class _RoutingMapState extends State<RoutingMap> {
  void initState() {
    super.initState();
  }

  double? latitute;
  double? longitude;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    // socket.disconnect();
    super.deactivate();
  }

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
                    return Stack(
                      children: [
                        GoogleMapRender(
                          startingLocation: transportData.startingLocation,
                          maphash: transportData.maphash,
                          list: transportData.list,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: getTextWidgets(list, size))
                          ],
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('No transport assigned to you.'),
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

  Widget getTextWidgets(List<ListTrasport> list, Size size) {
    List<Widget> rowlist = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      rowlist.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor),
            color: Colors.white,
          ),
          width: size.width * 0.95,
          height: size.height * 0.1,
          child: Row(children: [
            SvgPicture.asset(
              "assets/images/store.svg",
              height: size.height * 0.1,
              width: size.height * 0.1,
              color: kPrimaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list[i].name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  // Text("${list[i].lat}${list[i].lng}"),
                  Text(list[i].phone),
                  Text("Loading Time: ${list[i].loadingTime} mins")
                ],
              ),
            )
          ]),
        ),
      ));
    }
    return new Row(children: rowlist);
  }
}
