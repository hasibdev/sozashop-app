import 'dart:convert';

import 'package:http/http.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/environment.dart';

class ModuleService {
  final String mainUrl = Environment.apiUrl;

  Future fetchModule(int industryId) async {
    try {
      Response response =
          await get(Uri.parse(mainUrl + Strings.moduleUrl + '$industryId'));
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
