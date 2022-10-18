import 'package:sozashop_app/data/services/module_service.dart';

import '../models/module_model.dart';

class ModuleRepository {
  final ModuleService moduleService;
  ModuleRepository({required this.moduleService});

  Future<ModuleModel> fetchModule(int industryId) async {
    final modulesRaw = await moduleService.fetchModule(industryId);
    print('modulesRaw >>>>> ${modulesRaw["data"]}');
    List<ModuleModel> modules = [];

    // modulesRaw
    //! add to list

    var moduleData = ModuleModel.fromJson(modulesRaw);
    // return moduleData.data;
    print('moduleData >>>>> $moduleData');

    return modulesRaw;
  }
}
