import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:greentracker/models/server.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:requests/requests.dart';

class UserData {
  final String id, name, username, role, email, phone, address;

  UserData(this.id, this.name, this.username, this.role, this.email, this.phone,
      this.address);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        json['id'].toString(),
        json['name'].toString(),
        json['username'].toString(),
        json['role'].toString(),
        json['email'].toString(),
        json['phone'].toString(),
        json['address'].toString());
  }

  String getuser() {
    var t = username;
    return t;
  }
}

class UserDataAPI {
  final int status;
  final UserData? userData;

  const UserDataAPI(this.status, this.userData);
}

Future<UserDataAPI> getUserData() async {
  try {
    var response = await Requests.get('$serverurl/user')
        .timeout(const Duration(seconds: 20));
    print("ss21");
    if (response.statusCode == 200) {
      print("ss2");
      var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
      print("ss");
      UserData userData = UserData.fromJson(decoded['user']);
      // (await SharedPreferences.getInstance()).setString('userid', userData.id);
      var jar = await Requests.getStoredCookies(serverurl);
      return UserDataAPI(response.statusCode, userData);
    } else {
      userLogout();
      return const UserDataAPI(401, null);
    }
  } catch (error) {
    return const UserDataAPI(-1, null);
  }
}

Future<int> userLogin(username, password) async {
  try {
    // var response = await http.post(Uri.parse('$serverurl/login'), body: {
    //   'username': username,
    //   'password': password
    // }).timeout(const Duration(seconds: 20));

    username = "mawgyi";
    password = "Charon22@";
    var r = await Requests.post('$serverurl/login',
            body: {'username': username, 'password': password})
        .timeout(const Duration(seconds: 20));
    r.raiseForStatus();

    if (r.statusCode == 200) {
      // print(r.content());
      // UserData userData = UserData.fromJson(r.json());
      // print(userData.id);
      // (await SharedPreferences.getInstance()).setString('userid', userData.id);
      var decoded = await jsonDecode(r.body) as Map<String, dynamic>;

      var user = decoded['user'];
      var cookies = decoded['cookies']['sess'];
      UserData userData = UserData.fromJson(user);
      var cookiesJar = CookieJar.parseCookiesString("sess= $cookies");
      await Requests.setStoredCookies(serverurl, cookiesJar);
      (await SharedPreferences.getInstance()).setString('userid', userData.id);

      return r.statusCode;
    } else {
      return 401;
    }
    // if (response.statusCode == 200) {
    //   var decoded = await jsonDecode(response.body) as Map<String, dynamic>;
    //   UserData userData = UserData.fromJson(decoded['user']);
    //   print(userData.email);
    //   (await SharedPreferences.getInstance()).setString('userid', userData.id);

    //   return response.statusCode;
    // } else {
    //   return 401;
    // }
  } catch (error) {
    return -1;
  }
}

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

Future<int> userLogout() async {
  try {
    await Requests.get('$serverurl/logout');

    (await SharedPreferences.getInstance()).clear();
    await Requests.clearStoredCookies(Requests.getHostname(serverurl));
    return 200;
  } catch (error) {
    return -1;
  }
}
