import 'package:sozashop_app/data/models/industry_model.dart';
import 'package:sozashop_app/data/services/industry_service.dart';

class IndustryRepository {
  final IndustryService industryService;
  IndustryRepository({required this.industryService});

  Future<List<IndustryModel>> fetchIndustries() async {
    final industriesRaw = await industryService.fetchIndustries();
    var industryData = Industry.fromJson(industriesRaw);
    return industryData.data;
  }
}
