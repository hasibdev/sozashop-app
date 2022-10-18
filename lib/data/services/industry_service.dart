import 'dart:convert';

import 'package:http/http.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/environment.dart';

class IndustryService {
  final String mainUrl = Environment.apiUrl;

  Future fetchIndustries() async {
    try {
      Response response = await get(Uri.parse(mainUrl + Strings.industryUrl));
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
