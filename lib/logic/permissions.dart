import 'package:sozashop_app/logic/user_details.dart';

import '../data/models/profile_model.dart';

ProfileModel user = UserDetails.user as ProfileModel;

class Permissions {
  static bool hasPageViaClient(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];

    // ignore: unnecessary_null_comparison
    if (user == null) return false;

    // check for fields
    if (user.client?.fields == null) {
      return false;
    } else if (user.client!.fields!.isNotEmpty) {
      final findMenu =
          user.client?.fields?.firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);

      if (findPage != null) {
        return findPage.value;
      } else {
        return false;
      }
    }

    return false;
  }

  static bool hasPageViaModule(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];

    // ignore: unnecessary_null_comparison
    if (user == null) return false;

    if (user.client?.module.fields != null &&
        user.client!.module.fields.isNotEmpty) {
      final findMenu = user.client?.module.fields
          .firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);

      if (findPage != null) {
        return findPage.value;
      } else {
        print('$valuePage Permission not found, $value');
        return false;
      }
    }
    //! make it false
    return false;
  }

  // check the page permission for user
  static bool hasPagePermission(value) {
    if (value.runtimeType == bool) return value;
    return hasPageViaClient(value) || hasPageViaModule(value);
  }

  // check roles
  static bool hasRole(value) {
    final roles = user.roles;
    if (roles.isEmpty) {
      return false;
    } else {
      return roles.any((role) => role.name == value);
    }
  }

  // check permission
  static bool hasPermission(value) {
    final roles = user.roles;
    if (roles.isEmpty) {
      return false;
    }

    final permissions = roles.reduce(
      (acc, role) {
        for (var p in role.permissions) {
          acc.permissions.add(p.name);
        }
        return acc;
      },
    );

    return permissions.permissions.contains(value);
  }

  //check the fields permission for users
  static bool hasFieldViaClient(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];
    var valueField = splitedValue[2];

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return false;
    }

    // looking for the fields
    if (user.client!.fields!.isEmpty) {
      //! make it false
      return false;
    } else if (user.client!.fields != null) {
      final findMenu =
          user.client?.fields?.firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);
      final findField =
          findPage?.fields.firstWhere((field) => field.name == valueField);

      if (findField != null) {
        return findField.value;
      } else {
        return false;
      }
    }
    return false;
  }

  // check specific permissions for the user
  static bool hasFieldViaModule(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];
    var valueField = splitedValue[2];

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return false;
    }

    // looking for the fields in the module
    if (user.client?.module.fields != null &&
        user.client!.module.fields.isNotEmpty) {
      final findMenu = user.client?.module.fields
          .firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);
      final findField =
          findPage?.fields.firstWhere((field) => field.name == valueField);

      if (findField != null) {
        return findField.value;
      } else {
        return false;
      }
    }
    return false;
  }

  //check individual field permission for the user
  static bool hasFieldPermission(value) {
    if (value.runtimeType == bool) {
      return value;
    } else {
      return hasFieldViaClient(value) || hasFieldViaModule(value);
    }
  }

  // check action permission via module
  static bool hasActionViaModule(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];
    var valueAction = splitedValue[2];

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return false;
    }

    // looking for the fields in the module
    if (user.client?.module != null && user.client!.module.fields.isNotEmpty) {
      final findMenu = user.client?.module.fields
          .firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);
      final findAction =
          findPage?.actions?.firstWhere((action) => action.name == valueAction);

      if (findAction != null) {
        return findAction.value;
      } else {
        return false;
      }
    }
    return false;
  }

  // check action permission via client
  static bool hasActionViaClient(value) {
    var splitedValue = value.split(".");
    var valueMenu = splitedValue[0];
    var valuePage = splitedValue[1];
    var valueAction = splitedValue[2];

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return false;
    }

    // looking for the fields
    if (user.client?.fields != null) {
      final findMenu =
          user.client?.fields?.firstWhere((field) => field.name == valueMenu);
      final findPage =
          findMenu?.pages.firstWhere((page) => page.name == valuePage);
      final findAction =
          findPage?.actions?.firstWhere((action) => action.name == valueAction);

      if (findAction != null) {
        return findAction.value;
      } else {
        return false;
      }
    }
    return false;
  }

  //check individual action permission for the user
  static bool hasActionPermission(value) {
    if (value.runtimeType == bool) {
      return value;
    } else {
      return hasActionViaModule(value) || hasActionViaClient(value);
    }
  }
}
