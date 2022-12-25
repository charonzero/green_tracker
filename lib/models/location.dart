import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greentracker/models/login.dart';
import 'package:greentracker/models/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:requests/requests.dart';
// class Chapter extends Equatable {
//   final String chapterId, chapterName, description, price;
//   final bool subbed;
//   final List<Links> links;

//   const Chapter(this.chapterId, this.chapterName, this.description, this.price,
//       this.subbed, this.links);

//   factory Chapter.fromJson(Map<String, dynamic> json) {
//     return Chapter(
//       json['chapterId'].toString(),
//       json['chapterName'],
//       json['description'],
//       json['price'].toString(),
//       json['subbed'] ?? false,
//       json['links'] != null
//           ? json['links'].map<Links>((json) => Links.fromJson(json)).toList()
//           : [],
//     );
//   }

//   @override
//   List<Object> get props => [chapterId];

//   @override
//   bool get stringify => true;
// }

// class Links {
//   final String type, url;

//   const Links(this.type, this.url);

//   factory Links.fromJson(Map<String, dynamic> json) {
//     return Links(json['type'], json['url']);
//   }
// }

class TransportData extends Equatable {
  final String id,
      driverid,
      success,
      startingTime,
      estDistance,
      estTime,
      maphash,
      created;
  final LatLng startingLocation;

  final List<ListTrasport> list;

  const TransportData(
      this.id,
      this.driverid,
      this.success,
      this.startingLocation,
      this.startingTime,
      this.estDistance,
      this.estTime,
      this.maphash,
      this.created,
      this.list);

  factory TransportData.fromJson(Map<String, dynamic> json) {
    return TransportData(
      json['id'].toString(),
      json['driverid'].toString(),
      json['success'].toString(),
      LatLng(json['startingLocation']['lat'], json['startingLocation']['lng']),
      json['startingTime'].toString(),
      json['estDistance'].toString(),
      json['estTime'].toString(),
      json['maphash'],
      json['created'].toString(),
      json['list'] != null
          ? json['list']
              .map<ListTrasport>((json) => ListTrasport.fromJson(json))
              .toList()
          : [],
    );
  }

  @override
  List<Object> get props => [id];

  @override
  bool get stringify => true;
}

class ListTrasport {
  final String tcid,
      merchantid,
      name,
      phone,
      status,
      tid,
      arrivalTime,
      distanceTo,
      loadingTime;
  final double lat, lng;

  const ListTrasport(
      this.tcid,
      this.merchantid,
      this.name,
      this.phone,
      this.status,
      this.tid,
      this.arrivalTime,
      this.distanceTo,
      this.lat,
      this.lng,
      this.loadingTime);

  factory ListTrasport.fromJson(Map<String, dynamic> json) {
    return ListTrasport(
        json['tcid'].toString(),
        json['merchantid'].toString(),
        json['name'].toString(),
        json['phone'].toString(),
        json['status'].toString(),
        json['tid'].toString(),
        json['arrivalTime'].toString(),
        json['distanceTo'].toString(),
        json['lat'],
        json['lng'],
        json['loadingTime'].toString());
  }
  List<Object> get props => [tcid];

  bool get stringify => true;
}

class TransportAPI {
  final int status;
  final TransportData? transportData;

  const TransportAPI(this.status, this.transportData);
}

Future<TransportAPI> getTransportData() async {
  var response = await Requests.post('$serverurl/getTransport', body: {
    "userid": (await SharedPreferences.getInstance()).get('userid'),
  }).timeout(const Duration(seconds: 20));
  if (response.statusCode == 200) {
    var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
    TransportData transportData = TransportData.fromJson(decoded['transports']);
    return TransportAPI(response.statusCode, transportData);
  } else if (response.statusCode == 401) {
    return TransportAPI(response.statusCode, null);
  } else {
    return TransportAPI(response.statusCode, null);
  }
}

Future<TransportData> sendCurrentLocationData() async {
  var response = await Requests.post('$serverurl/updateLocation', body: {
    "userid": (await SharedPreferences.getInstance()).get('userid'),
    "lat": 0,
    "lng": 0
  }).timeout(const Duration(seconds: 20));
  var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
  TransportData transportData = TransportData.fromJson(decoded['transports']);
  // var decoded = await TransportData.fromJson(response.body)(
  //         await SharedPreferences.getInstance())
  //  .setString('userid', decoded['id'].toString());
  return transportData;
}
