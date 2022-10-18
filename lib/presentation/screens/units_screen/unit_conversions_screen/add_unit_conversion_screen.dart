import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

import '../../../../data/models/unit_model.dart';
import '../../widgets/k_button.dart';
import '../../widgets/k_text_field.dart';

class AddUnitConversionScreen extends StatefulWidget {
  const AddUnitConversionScreen({Key? key}) : super(key: key);

  @override
  State<AddUnitConversionScreen> createState() =>
      _AddUnitConversionScreenState();
}

class _AddUnitConversionScreenState extends State<AddUnitConversionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UnitModel? baseUnit;
  List<UnitModel>? units;
  List<String> operators = ["/", "*"];
  TextEditingController valueController = TextEditingController();

  var selectedUnit;
  var selectedUnitId;
  var selectedOperator;
  bool allSelected = false;
  getUnitId() {
    selectedUnitId =
        units?.firstWhere((element) => element.name == selectedUnit).id;
    print(selectedUnitId);
  }

  @override
  Widget build(BuildContext context) {
    // nameController.text = 'Liter';
    // codeController.text = 'ltr';
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UnitBloc>(context).add(GoUnitDetailPage(
          unitModel: baseUnit!,
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text($t('conversions.title.add')),
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
            if (state is UnitConversionAddingState) {
              baseUnit = state.baseUnit;
              units = state.allUnits!
                  .where((element) => element.name != baseUnit?.name)
                  .map((e) => e)
                  .toList();
            }
            return Form(
              key: _formKey,
              child: KPage(
                children: [
                  KPageMiddle(
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
                        value: selectedUnit,
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value;
                            print(selectedUnit);
                            getUnitId();
                          });
                        },
                      ),
                      KDropdown(
                        labelText: $t('fields.operator'),
                        isRequired: true,
                        items: operators,
                        value: selectedOperator,
                        onChanged: (value) {
                          setState(() {
                            selectedOperator = value;
                            print(selectedOperator);
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
                    ],
                  ),
                  KPageButtonsRow(
                    buttons: [
                      Expanded(
                        child: KFilledButton(
                          text: $t('buttons.submit'),
                          onPressed: () async {
                            var isValid = _formKey.currentState!.validate();
                            if (selectedOperator != null &&
                                selectedUnitId != null) {
                              allSelected = true;
                            } else {
                              allSelected = false;
                            }

                            if (isValid && allSelected) {
                              BlocProvider.of<UnitBloc>(context)
                                  .add(AddUnitConversion(
                                baseUnit: baseUnit!,
                                baseUnitId: baseUnit!.id.toString(),
                                unitOperator: selectedOperator,
                                unitId: selectedUnitId.toString(),
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
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
