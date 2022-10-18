import '../../l10n/app_localization.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension ErrorsAsList on Map {
  String errorsToString() {
    // ignore: unnecessary_cast
    if ((this as Map).containsKey('errors')) {
      var mappedErrors = Map.of(this['errors']);
      var errs = [];
      mappedErrors.forEach((key, value) {
        errs.addAll(value);
      });
      var joinedAsList = errs.join('\n');
      return joinedAsList;
      // ignore: unnecessary_cast
    } else if (!(this as Map).containsKey('errors')) {
      toString();
    }
    return toString();
  }

  String errMsgToString() {
    var message = "Something went wrong!";
    // ignore: unnecessary_cast
    if ((this as Map).containsKey('errors')) {
      var mappedErrors = Map.of(this['errors']);
      if (mappedErrors.isEmpty) {
        message = this['message'];
      }
    }
    return message;
  }
}

// Extension for localization
String $t(String key) {
  return AppLocalizations.instance.translate(key);
}

// get the id of the selected item from the list
int getSelectedIdFromName(List<dynamic> list, dynamic selectedItem) {
  return list.firstWhere((element) => element.name == selectedItem).id;
}

String getSelectedNameFromId(List<dynamic> list, dynamic selectedItemId) {
  return list.firstWhere((element) => element.id == selectedItemId).name;
}

String getSelectedValueFromName(List<dynamic> list, dynamic selectedItem) {
  return list.firstWhere((element) => element.name == selectedItem).value;
}

// check if the lists are equal
extension on List {
  bool equals(List list) {
    if (length != list.length) return false;
    return every((item) => list.contains(item));
  }
}
