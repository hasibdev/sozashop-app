part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

// class LanguageInitial extends LanguageState {
//   final Locale? locale;
//   const LanguageInitial({this.locale});
//   @override
//   List<Object?> get props => [locale];
// }
class LanguageInitial extends LanguageState {
  final String? code;
  const LanguageInitial({this.code});
  @override
  List<Object?> get props => [code];
}

// class LanguageChanged extends LanguageState {
//   final Locale? locale;
//   final String? name;
//   const LanguageChanged({this.locale, this.name});
//   @override
//   List<Object?> get props => [locale, name];
// }

class LanguageChanged extends LanguageState {
  final String? code;
  final String? name;
  const LanguageChanged({this.code, this.name});
  @override
  List<Object?> get props => [code, name];

  Map<String, dynamic> toMap() {
    return {
      'code': code ?? '',
      'name': name ?? '',
    };
  }

  factory LanguageChanged.fromMap(Map<String, dynamic> map) {
    return LanguageChanged(
      code: map['code'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageChanged.fromJson(String source) =>
      LanguageChanged.fromMap(json.decode(source));
}
