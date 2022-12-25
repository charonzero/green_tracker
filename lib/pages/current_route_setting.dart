import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greentracker/models/location.dart';
import 'package:greentracker/pages/deliver_control.dart';
import '../constants.dart';

class CurrentRouteSettingScreen extends StatelessWidget {
  const CurrentRouteSettingScreen({super.key});

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
                    return SingleChildScrollView(
                      child: getDestinationWidgets(list, size, context),
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

  Widget getDestinationWidgets(
      List<ListTrasport> list, Size size, BuildContext context) {
    if (list.isNotEmpty) {
      List<Widget> rowlist = <Widget>[];

      for (var i = 0; i < list.length; i++) {
        rowlist.add(Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            // onDoubleTap: () => {merchantBtn(list[i])},
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliverControlScreen(
                    id: int.parse(list[i].tcid),
                  ),
                ),
              )
            },
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
                      Text(list[i].status)
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
      }
      return Column(children: rowlist);
    } else {
      return const CircularProgressIndicator();
    }
  }
}
