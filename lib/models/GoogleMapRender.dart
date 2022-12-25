// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/models/location.dart';

class GoogleMapRender extends StatefulWidget {
  final String maphash;
  final List<ListTrasport> list;
  final LatLng startingLocation;
  const GoogleMapRender(
      {super.key,
      required this.maphash,
      required this.list,
      required this.startingLocation});

  @override
  State<GoogleMapRender> createState() => _GoogleMapRenderState();
}

class _GoogleMapRenderState extends State<GoogleMapRender> {
  late final LatLng _initialcameraposition = LatLng(
      widget.startingLocation.latitude, widget.startingLocation.longitude);
  late GoogleMapController _controller;

  Map<PolylineId, Polyline> polylines = {};

  late BitmapDescriptor pinLocationIcon;

  void _onMapCreated(GoogleMapController cntlr) async {
    _controller = cntlr;
    setMarkers();
    getPolyPoints();
  }

  void setMarkers() async {
    const oneSec = Duration(seconds: 5);
    if (mounted) {
      Timer.periodic(oneSec, (Timer t) async {
        PolylinePoints polylinePoints = PolylinePoints();
        try {
          List<PointLatLng> result =
              polylinePoints.decodePolyline(widget.maphash);
          if (result.isNotEmpty) {
            List<LatLng> polylineCoordinates = [];
            for (var point in result) {
              polylineCoordinates.add(
                LatLng(point.latitude, point.longitude),
              );
            }
            PolylineId id = const PolylineId("poly");
            Polyline polyline = Polyline(
                zIndex: 0,
                polylineId: id,
                color: kPrimaryColor,
                points: polylineCoordinates,
                width: 4);
            if (mounted) {
              setState(() {
                polylines[id] = polyline;
              });
            }
          }
        } catch (err) {
          // print(err);
        }
      });
    }
  }

  List<ListTrasport> getWaitingList(List<ListTrasport> list) {
    List<ListTrasport> outputList =
        list.where((o) => o.status == "waiting").toList();
    return outputList;
  }

  final Location _location = Location();

  void getPolyPoints() async {
    _location.onLocationChanged.distinct().listen((l) async {
      PolylinePoints polylinePoints = PolylinePoints();
      List<ListTrasport> currentdestination = getWaitingList(widget.list);
      if (currentdestination.isNotEmpty) {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyAd0VwAFBuzdxchIU2id4jWKonH-6qFZQU",
          PointLatLng(l.latitude!, l.longitude!),
          PointLatLng(currentdestination[0].lat, currentdestination[0].lng),
        );
        if (result.points.isNotEmpty) {
          List<LatLng> polylineCoordinates = [];
          for (var point in result.points) {
            polylineCoordinates.add(
              LatLng(point.latitude, point.longitude),
            );
          }
          PolylineId id = const PolylineId("driverpoly");
          Polyline polyline = Polyline(
              zIndex: 1,
              polylineId: id,
              color: Colors.red,
              points: polylineCoordinates,
              width: 4);
          if (mounted) {
            setState(() {
              polylines[id] = polyline;
            });
          }
        }
      }
    });
    _location.changeSettings(accuracy: LocationAccuracy.low, interval: 5000);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(target: _initialcameraposition),
          mapType: MapType.normal,
          minMaxZoomPreference: const MinMaxZoomPreference(14, 18),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          polylines: Set<Polyline>.of(polylines.values),
          markers: {
            for (var i = 0; i < widget.list.length; i++) ...[
              Marker(
                markerId: MarkerId(widget.list[i].tid),
                position: LatLng(widget.list[i].lat, widget.list[i].lng),
                infoWindow: InfoWindow(
                  title: widget.list[i].name,
                  snippet: "${widget.list[i].lat}${widget.list[i].lng}",
                ),
                draggable: false,
                onDragEnd: (value) {},
              ),
            ],
            Marker(
              alpha: 0.95,
              icon: BitmapDescriptor.defaultMarkerWithHue(224),
              flat: true,
              markerId: const MarkerId("Factory"),
              position: LatLng(widget.startingLocation.latitude,
                  widget.startingLocation.longitude),
              infoWindow: const InfoWindow(
                title: 'Factory',
              ),
            ),
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: getDestinationWidgets(widget.list, size))
          ],
        )
      ],
    );
  }

  Future<void> merchantBtn(ListTrasport list) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${list.name}"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(list.name)
                // Text('This is a demo alert dialog.'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Success'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Canceled'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getDestinationWidgets(List<ListTrasport> list, Size size) {
    List<Widget> rowlist = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      rowlist.add(Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onDoubleTap: () => {merchantBtn(list[i])},
          onTap: () => {
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(list[i].lat, list[i].lng), zoom: 15),
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
                    Text("Loading Time: ${list[i].loadingTime} mins")
                  ],
                ),
              )
            ]),
          ),
        ),
      ));
    }
    return Row(children: rowlist);
  }
}
