import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../logic/bloc/category_bloc/category_bloc.dart';
import '../widgets/k_button.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({Key? key}) : super(key: key);

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var _selectedStatus;
  var _stateSelectedStatus;
  int? categoryId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CategoryBloc>(context)
          ..add(GoAllCategoriesPage())
          ..add(const FetchCategories());
        return false;
      },
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryEditingState) {
            nameController.text = state.categoryName ?? '';
            descriptionController.text = state.description ?? '';

            _stateSelectedStatus = state.status;
            categoryId = state.categoryId;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text($t('categories.title.edit')),
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<CategoryBloc>(context)
                    ..add(GoAllCategoriesPage())
                    ..add(const FetchCategories());
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            body: Form(
              key: _formKey,
              child: KPage(
                children: [
                  KPageMiddle(
                    xPadding: kPaddingX,
                    yPadding: kPaddingY,
                    isExpanded: false,
                    children: [
                      KTextField(
                        labelText: $t("fields.name"),
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
                        labelText: $t("fields.description"),
                        controller: descriptionController,
                        maxLines: 8,
                        textInputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                        hasPermission: Permissions.hasFieldPermission(
                            'categories.edit-category.description'),
                      ),
                      KDropdown(
                        labelText: $t("fields.status"),
                        hasMargin: false,
                        value: _selectedStatus ?? _stateSelectedStatus,
                        hasPermission: Permissions.hasFieldPermission(
                            'categories.edit-category.status'),
                        items: const ['active', 'inactive'],
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  KPageButtonsRow(
                    buttons: [
                      Expanded(
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return KFilledButton(
                              text: $t('buttons.update'),
                              onPressed: () async {
                                var isValid = _formKey.currentState!.validate();

                                if (isValid) {
                                  if (state is CategoryEditingState) {
                                    categoryId = state.categoryId;

                                    BlocProvider.of<CategoryBloc>(context)
                                        .add(EditCategory(
                                      categoryId: state.categoryId,
                                      categoryName: nameController.text,
                                      description: descriptionController.text,
                                      status: _selectedStatus ??
                                          _stateSelectedStatus,
                                    ));
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
