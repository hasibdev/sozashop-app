import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:sozashop_app/l10n/l10n.dart';

import 'dart:convert';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState>
    with HydratedMixin {
  LanguageBloc() : super(const LanguageInitial(code: 'en')) {
    on<ChangeLanguage>((event, emit) async {
      String? code = event.code;
      var _name = L10n.getLanguageName(code as String);

      emit(LanguageChanged(code: code, name: _name));
    });
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageChanged.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    if (state is LanguageChanged) {
      return state.toMap();
    }
    return null;
  }
}
