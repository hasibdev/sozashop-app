import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../logic/bloc/category_bloc/category_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_button.dart';
import '../widgets/k_text_field.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CategoryBloc>(context)
          ..add(GoAllCategoriesPage())
          ..add(const FetchCategories());
        return false;
      },
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: Text($t('categories.title.add')),
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<CategoryBloc>(context)
                    ..add(GoAllCategoriesPage())
                    ..add(const FetchCategories());
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          body: Form(
            key: _formKey,
            child: KPage(
              children: [
                KPageMiddle(
                  isExpanded: false,
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    KTextField(
                      labelText: $t('fields.name'),
                      controller: nameController,
                      isRequired: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Category name is required!';
                        }
                        return null;
                      },
                    ),
                    KTextField(
                      labelText: $t('fields.description'),
                      controller: descriptionController,
                      hasMargin: false,
                      maxLines: 5,
                      textInputType: TextInputType.multiline,
                      inputAction: TextInputAction.newline,
                      hasPermission: Permissions.hasFieldPermission(
                          'categories.add-category.description'),
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
                            BlocProvider.of<CategoryBloc>(context)
                                .add(AddCategory(
                              name: nameController.text,
                              description: descriptionController.text,
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
