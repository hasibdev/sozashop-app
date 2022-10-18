part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  // final Locale? locale;
  final String? code;

  const ChangeLanguage(this.code);
  @override
  List<Object?> get props => [];
}
