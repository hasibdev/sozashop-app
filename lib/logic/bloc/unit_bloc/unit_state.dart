part of 'unit_bloc.dart';

abstract class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object> get props => [];
}

class UnitInitial extends UnitState {}

class LoadingState extends UnitState {}

class UnitsLoading extends UnitState {}

class UnitsFetched extends UnitState {
  List<UnitModel> units;
  UnitsFetched({
    required this.units,
  });

  @override
  List<Object> get props => [units];
}

class UnitAddingState extends UnitState {}

class UnitAddedState extends UnitState {}

class UnitAddingFailed extends UnitState {
  final Map error;
  const UnitAddingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitAddingFailed { error: $error }';
}

class UnitDeletedState extends UnitState {}

class UnitDeletingFailed extends UnitState {
  final Map error;
  const UnitDeletingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitDeletingFailed { error: $error }';
}

class UnitEditingState extends UnitState {
  int unitId;
  String unitName;
  String unitCode;

  UnitEditingState({
    required this.unitId,
    required this.unitName,
    required this.unitCode,
  });

  @override
  List<Object> get props => [];
}

class UnitEditedState extends UnitState {}

class UnitEditingFailed extends UnitState {
  final Map error;
  const UnitEditingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitEditingFailed { error: $error }';
}

class UnitDetailState extends UnitState {
  UnitModel? unit;
  List<UnitConversionModel>? unitConversions;

  UnitDetailState({
    this.unit,
    this.unitConversions,
  });

  @override
  List<Object> get props => [unit!, unitConversions!];
}

class UnitConversionsLoading extends UnitState {}

class UnitConversionsFetched extends UnitState {
  List<UnitConversionModel> unitConversions;
  UnitConversionsFetched({
    required this.unitConversions,
  });

  @override
  List<Object> get props => [unitConversions];
}

class UnitConversionDeletedState extends UnitState {}

class UnitConversionDeletingFailed extends UnitState {
  final Map error;
  const UnitConversionDeletingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitDeletingFailed { error: $error }';
}

class UnitConversionDetailState extends UnitState {
  UnitConversionModel unitConversionModel;

  UnitConversionDetailState({
    required this.unitConversionModel,
  });

  @override
  List<Object> get props => [unitConversionModel];
}

class UnitConversionAddingState extends UnitState {
  UnitModel baseUnit;
  List<UnitModel>? allUnits;
  UnitConversionAddingState({
    required this.baseUnit,
    this.allUnits,
  });
  @override
  List<Object> get props => [baseUnit];
}

class UnitConversionAddedState extends UnitState {}

class UnitConversionAddingFailed extends UnitState {
  final Map error;
  const UnitConversionAddingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitAddingFailed { error: $error }';
}

class UnitConversionEditingState extends UnitState {
  UnitModel baseUnit;
  List<UnitModel>? allUnits;
  UnitConversionModel unitConversionModel;

  UnitConversionEditingState({
    required this.baseUnit,
    required this.unitConversionModel,
    this.allUnits,
  });
  @override
  List<Object> get props => [baseUnit, unitConversionModel];
}

class UnitConversionEditedState extends UnitState {}

class UnitConversionEditingFailed extends UnitState {
  final Map error;
  const UnitConversionEditingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UnitAddingFailed { error: $error }';
}
