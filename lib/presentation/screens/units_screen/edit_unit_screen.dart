import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../logic/bloc/unit_bloc/unit_bloc.dart';

class EditUnitScreen extends StatefulWidget {
  const EditUnitScreen({Key? key}) : super(key: key);

  @override
  State<EditUnitScreen> createState() => _EditUnitScreenState();
}

class _EditUnitScreenState extends State<EditUnitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  int? unitId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UnitBloc>(context)
          ..add(GoAllUnitsPage())
          ..add(FetchUnits());
        return false;
      },
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UnitEditingState) {
            nameController.text = state.unitName;
            codeController.text = state.unitCode;
            unitId = state.unitId;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text($t('unit.title.edit')),
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<UnitBloc>(context)
                      ..add(GoAllUnitsPage())
                      ..add(FetchUnits());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            body: Form(
              key: _formKey,
              child: KPage(children: [
                KPageMiddle(
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    KTextField(
                      labelText: $t("fields.name"),
                      controller: nameController,
                      isRequired: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Unit name is required!';
                        }
                        return null;
                      },
                    ),
                    KTextField(
                      labelText: $t("fields.code"),
                      controller: codeController,
                      inputAction: TextInputAction.send,
                      isRequired: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Code is required!';
                        }
                        return null;
                      },
                    ),
                    BlocBuilder<UnitBloc, UnitState>(
                      builder: (context, state) {
                        return KFilledButton(
                          text: $t('buttons.update'),
                          onPressed: () async {
                            var isValid = _formKey.currentState!.validate();

                            if (isValid) {
                              if (state is UnitEditingState) {
                                unitId = state.unitId;

                                BlocProvider.of<UnitBloc>(context).add(EditUnit(
                                  unitId: unitId!.toInt(),
                                  unitName: nameController.text,
                                  unitCode: codeController.text,
                                ));
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
