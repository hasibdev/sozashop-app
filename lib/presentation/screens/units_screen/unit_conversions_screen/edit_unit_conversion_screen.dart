import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

import '../../../../data/models/unit_model.dart';
import '../../widgets/k_button.dart';
import '../../widgets/k_text_field.dart';

class EditUnitConversionScreen extends StatefulWidget {
  const EditUnitConversionScreen({Key? key}) : super(key: key);

  @override
  State<EditUnitConversionScreen> createState() =>
      _EditUnitConversionScreenState();
}

class _EditUnitConversionScreenState extends State<EditUnitConversionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UnitModel? baseUnit;
  List<UnitModel>? units;
  List<String> operators = ["/", "*"];
  TextEditingController valueController = TextEditingController();
  UnitConversionModel? unitConversionDetails;

  var selectedUnit;
  var selectedUnitId;
  var selectedOperator;
  var updatedDetails;
  bool allSelected = false;
  getUnitId() {
    selectedUnitId =
        units?.firstWhere((element) => element.name == selectedUnit).id;
  }

  @override
  Widget build(BuildContext context) {
    valueController.text = unitConversionDetails?.value ?? '';

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UnitBloc>(context).add(GoUnitDetailPage(
          unitModel: baseUnit!,
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text($t('conversions.title.edit')),
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<UnitBloc>(context).add(GoUnitDetailPage(
                  unitModel: baseUnit!,
                ));
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: BlocConsumer<UnitBloc, UnitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UnitConversionEditingState) {
              unitConversionDetails = state.unitConversionModel;
              valueController.text = unitConversionDetails?.value ?? '';

              baseUnit = state.baseUnit;
              units = state.allUnits!
                  .where((element) => element.name != baseUnit?.name)
                  .map((e) => e)
                  .toList();
            }
            return KPage(
              children: [
                Form(
                  key: _formKey,
                  child: KPageMiddle(
                    xPadding: kPaddingX,
                    yPadding: kPaddingY,
                    children: [
                      KDropdown(
                        labelText: $t('fields.baseUnit'),
                        value: baseUnit!.name,
                        items: [baseUnit!.name],
                      ),
                      KDropdown(
                        labelText: $t('fields.unit'),
                        isRequired: true,
                        items: units?.map((e) => e.name).toList(),
                        value: selectedUnit ?? unitConversionDetails?.unitName,
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value;
                            getUnitId();
                          });
                        },
                      ),
                      KDropdown(
                        labelText: $t('fields.operator'),
                        isRequired: true,
                        items: operators,
                        value: selectedOperator ??
                            unitConversionDetails?.unitOperator,
                        onChanged: (value) {
                          setState(() {
                            selectedOperator = value;
                          });
                        },
                      ),
                      KTextField(
                        labelText: $t('fields.value'),
                        controller: valueController,
                        isRequired: true,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Value is required!';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        'Formula: (Base Unit * Value = Unit) Or (Base Unit / Value = Unit)',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      KFilledButton(
                        text: $t('buttons.submit'),
                        onPressed: () async {
                          var isValid = _formKey.currentState!.validate();
                          if (selectedOperator != null &&
                              selectedUnitId != null) {
                            selectedOperator =
                                unitConversionDetails?.unitOperator;
                            selectedUnitId = unitConversionDetails?.unit.id;

                            allSelected = true;
                          }

                          updatedDetails = unitConversionDetails?.copyWith(
                            unitId: selectedUnitId,
                            datumOperator: selectedOperator,
                            value: valueController.text,
                          );

                          if (isValid) {
                            BlocProvider.of<UnitBloc>(context)
                                .add(EditUnitConversion(
                              baseUnit: baseUnit!,
                              unitConversionItem: updatedDetails,
                              conversionId: unitConversionDetails!.id,
                              baseUnitId: baseUnit!.id,
                              unitOperator: selectedOperator ??
                                  unitConversionDetails?.unitOperator,
                              unitId: selectedUnitId ??
                                  unitConversionDetails?.unit.id,
                              value: valueController.text,
                            ));
                          } else {
                            KSnackBar(
                              context: context,
                              type: AlertType.failed,
                              message: "Please fill all the required fields!",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
