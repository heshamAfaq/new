import 'dart:convert';

import 'package:enivronment/domain/model/EpicintersModel.dart';
import 'package:enivronment/domain/model/ReportModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import '../../domain/model/epicenter/epicenter_model.dart';
import '../../domain/model/epicenter_model.dart';
import '../../presentation/login/login_screen.dart';

class AllEpicenterServices {
  static Future getAllEpicenter(int pageNum, int regionId) async {
    http.Response res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/Epicenters/GetAllEpicenters?page=$pageNum&pageSize=10&regionId=$regionId'),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPreferencesHelper.getTokenValue()}',
        'lang': Get.locale!.languageCode
      },
    );
    print(res.body);

    if (res.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(res.body)['epicenters'];
      String totalItem = jsonDecode(res.body)['count'];

      List<EpicenterDataModel> epicenters = jsonData.map((element) {
        return EpicenterDataModel.fromJson(element);
      }).toList();
      // return epicenters;
      return [epicenters, totalItem];
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      Get.offAll(() => const LoginScreen());
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

  getEpicenters(int pageNum, int regionId) async {
    http.Response res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/Epicenters/GetAllEpicenters?page=$pageNum&pageSize=10&regionId=$regionId'),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPreferencesHelper.getTokenValue()}',
        'lang': Get.locale!.languageCode
      },
    );

    print("Epicent");
    print(res.body);
    if (res.statusCode == 200) {
      EpicintersModel model = EpicintersModel.fromJson(jsonDecode(res.body));
      print(model.toJson());
      return model;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      Get.offAll(() => const LoginScreen());
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }
  getEpicentersbyId(int id) async {
    http.Response res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/Epicenters/GetEpicenter/$id'),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPreferencesHelper.getTokenValue()}',
        'lang': Get.locale!.languageCode
      },
    );

    print("Epicent");
    print(res.body);
    if (res.statusCode == 200) {
      ReportModel model = ReportModel.fromJson(jsonDecode(res.body));
      print(model.toJson());
      return model;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      Get.offAll(() => const LoginScreen());
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }
}
