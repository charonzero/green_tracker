// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:greentracker/models/server.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class UserData {
//   final String id, name, username, role, email, phone, address;

//   UserData(this.id, this.name, this.username, this.role, this.email, this.phone,
//       this.address);

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//         json['id'].toString(),
//         json['name'].toString(),
//         json['username'].toString(),
//         json['role'].toString(),
//         json['email'].toString(),
//         json['phone'].toString(),
//         json['address'].toString());
//   }

//   String getuser() {
//     var t = username;
//     return t;
//   }
// }

// Future<int> userLogin(username, password) async {
//   try {
//     var response = await http.post(Uri.parse('$serverurl/login'), body: {
//       'username': username,
//       'password': password
//     }).timeout(const Duration(seconds: 20));
//     if (response.statusCode == 200) {
//       var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
//       UserData userData = UserData.fromJson(decoded['user']);
//       (await SharedPreferences.getInstance()).setString('userid', userData.id);

//       return response.statusCode;
//     } else {
//       return 401;
//     }
//   } catch (error) {
//     return -1;
//   }
// }

// Future<int> userSignup(username, password, email, phone) async {
//   try {
//     var response = await http.post(Uri.parse('$serverurl/signup'), body: {
//       'username': username,
//       'password': password,
//       'email': email,
//       'phone': phone
//     }).timeout(const Duration(seconds: 20));
//     if (response.statusCode == 200) {
//       var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
//       UserData userData = UserData.fromJson(decoded['user']);
//       (await SharedPreferences.getInstance()).setString('userid', userData.id);
//       return response.statusCode;
//     } else {
//       return 401;
//     }
//   } catch (error) {
//     return -1;
//   }
// }

// Future<int> userLogout() async {
//   try {
//     await http.get(Uri.parse('$serverurl/logout'));

//     (await SharedPreferences.getInstance()).clear();
//     return 200;
//   } catch (error) {
//     return -1;
//   }
// }
