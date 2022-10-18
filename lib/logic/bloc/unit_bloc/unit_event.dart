part of 'unit_bloc.dart';

abstract class UnitEvent extends Equatable {
  const UnitEvent();

  @override
  List<Object> get props => [];
}

class FetchUnits extends UnitEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchUnits({this.pageNo, this.perPage, this.searchText});
}

class GoAddUnitPage extends UnitEvent {}

class GoAllUnitsPage extends UnitEvent {}

class AddUnit extends UnitEvent {
  String unitName;
  String unitCode;
  AddUnit({
    required this.unitName,
    required this.unitCode,
  });

  @override
  List<Object> get props => [unitName, unitCode];
}

class DeleteUnit extends UnitEvent {
  int unitId;
  DeleteUnit({
    required this.unitId,
  });
  @override
  List<Object> get props => [unitId];
}

class GoEditUnitPage extends UnitEvent {
  UnitModel unitModel;
  GoEditUnitPage({
    required this.unitModel,
  });

  @override
  List<Object> get props => [unitModel];
}

class EditUnit extends UnitEvent {
  int unitId;
  String unitName;
  String unitCode;

  EditUnit({
    required this.unitId,
    required this.unitName,
    required this.unitCode,
  });

  @override
  List<Object> get props => [unitId, unitName, unitCode];
}

class GoUnitDetailPage extends UnitEvent {
  UnitModel unitModel;
  GoUnitDetailPage({
    required this.unitModel,
  });
  @override
  List<Object> get props => [unitModel];
}

class FetchUnitConversions extends UnitEvent {
  final int baseUnitId;
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchUnitConversions({
    required this.baseUnitId,
    this.pageNo,
    this.perPage,
    this.searchText,
  });

  @override
  List<Object> get props => [baseUnitId];
}

class DeleteUnitConversion extends UnitEvent {
  UnitModel baseUnit;
  int unitConversionId;
  DeleteUnitConversion({
    required this.baseUnit,
    required this.unitConversionId,
  });
  @override
  List<Object> get props => [baseUnit, unitConversionId];
}

class GoUnitConversionDetailPage extends UnitEvent {
  UnitConversionModel unitConversionModel;
  GoUnitConversionDetailPage({
    required this.unitConversionModel,
  });
  @override
  List<Object> get props => [unitConversionModel];
}

class AddUnitConversion extends UnitEvent {
  UnitModel baseUnit;
  String baseUnitId;
  String unitOperator;
  String unitId;
  String value;
  AddUnitConversion({
    required this.baseUnitId,
    required this.baseUnit,
    required this.unitOperator,
    required this.unitId,
    required this.value,
  });

  @override
  List<Object> get props => [baseUnitId, unitOperator, unitId, value];
}

class GoAddUnitConversionPage extends UnitEvent {
  UnitModel baseUnit;
  GoAddUnitConversionPage({
    required this.baseUnit,
  });
  @override
  List<Object> get props => [baseUnit];
}

class GoEditUnitConversionPage extends UnitEvent {
  UnitModel baseUnit;
  UnitConversionModel unitConversionModel;
  GoEditUnitConversionPage({
    required this.baseUnit,
    required this.unitConversionModel,
  });

  @override
  List<Object> get props => [baseUnit, unitConversionModel];
}

class EditUnitConversion extends UnitEvent {
  UnitConversionModel unitConversionItem;
  UnitModel baseUnit;
  int conversionId;
  var baseUnitId;
  String unitOperator;
  var unitId;
  String value;
  EditUnitConversion({
    required this.conversionId,
    required this.unitConversionItem,
    required this.baseUnit,
    required this.baseUnitId,
    required this.unitOperator,
    required this.unitId,
    required this.value,
  });

  @override
  List<Object> get props =>
      [unitConversionItem, baseUnit, baseUnitId, unitOperator, unitId, value];
}
