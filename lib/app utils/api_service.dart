import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  static Uri url(int nrResults) {
    Uri nrUser = Uri.parse('http://api.randomuser.me/?results=$nrResults');
    return nrUser;
  }

  static Future<List<UserModel>> getUsers({int nrUsers = 1}) async {
    try {
      var response = await http
          .get(url(nrUsers), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        Iterable list = data["results"];
        List<UserModel> users = list.map((l) => UserModel.fromJson(l)).toList();
        return users;
      } else {
        print(response.body);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
