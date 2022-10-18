import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../widgets/k_button.dart';

class AddUnitScreen extends StatelessWidget {
  AddUnitScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UnitBloc>(context)
          ..add(GoAllUnitsPage())
          ..add(FetchUnits());
        return false;
      },
      child: BlocListener<UnitBloc, UnitState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: Text($t('unit.title.add')),
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
            child: KPage(
              children: [
                KPageMiddle(
                  isExpanded: false,
                  children: [
                    KTextField(
                      labelText: $t('fields.name'),
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
                      labelText: $t('fields.code'),
                      controller: codeController,
                      isRequired: true,
                      hasMargin: false,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Code is required!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                KPageButtonsRow(
                  buttons: [
                    Expanded(
                      child: KFilledButton(
                        text: $t('buttons.submit'),
                        onPressed: () async {
                          var isValid = _formKey.currentState!.validate();

                          if (isValid) {
                            BlocProvider.of<UnitBloc>(context).add(AddUnit(
                              unitName: nameController.text,
                              unitCode: codeController.text,
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
