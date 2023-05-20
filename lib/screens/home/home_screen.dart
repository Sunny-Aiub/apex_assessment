import 'package:apex_assessment/models/home/company_list_response.dart';
import 'package:apex_assessment/resources/colors.dart';
import 'package:apex_assessment/resources/components/input_widget.dart';
import 'package:apex_assessment/resources/font_sizes.dart';
import 'package:apex_assessment/resources/font_weights.dart';
import 'package:apex_assessment/resources/utils.dart';
import 'package:apex_assessment/resources/validators.dart';
import 'package:apex_assessment/view_models/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import '../../resources/components/general_exceptions_widget.dart';
import '../../resources/components/internet_exception_widget.dart';
import '../../resources/status.dart';

class HomeScreen extends GetView<HomeViewModel> {
  final HomeViewModel _homeViewModel = Get.put(HomeViewModel());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Obx(
          () {
            switch (_homeViewModel.rxRequestStatus.value) {
              case ApiStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ApiStatus.error:
                return GeneralExceptionWidget(onPress: () {
                  _homeViewModel.refreshUI();
                });
              case ApiStatus.completed:
                if (_homeViewModel.items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return buildListView();
                }
            }
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Get.dialog(
                barrierDismissible: false,
                buildDialog(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.buttonBackgroundColor),
              child: Text(
                'Create Company',
                style: Utils().getTextStyle(
                    FontSizeManager.px12, FontWeightManager.w600, Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildDialog() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 90),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _homeViewModel.formKey,
            child: Material(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 38),
                      InkWell(
                          onTap: () {
                            Get.back();
                            _homeViewModel.clearTextFields();
                          },
                          child: Icon(Icons.clear))
                    ],
                  ),
                  Text(
                    'Create a New Company',
                    style: Utils().getTextStyle(
                        FontSizeManager.px22,
                        FontWeightManager.w700,
                        AppColors.createScreenTextColor),
                  ),
                  const SizedBox(height: 38),
                  InputWidget(
                    controller: _homeViewModel.companyNameController.value,
                    isEnabled: true,
                    hintText: 'Company Name',
                    border: Border.all(color: AppColors.borderColor),
                    validator: (value) =>
                        MyCustomValidator.validateIsEmpty(value),
                  ),
                  const SizedBox(height: 16),

                  InputWidget(
                    controller: _homeViewModel.emailController.value,
                    isEnabled: true,
                    hintText: 'Work Email',
                    border: Border.all(color: AppColors.borderColor),
                    validator: (value) =>
                        MyCustomValidator.validateIsEmpty(value),
                  ),
                  const SizedBox(height: 16),

                  InputWidget(
                    controller: _homeViewModel.passwordController.value,
                    isEnabled: true,
                    obscureText: true,
                    hintText: 'Password',
                    border: Border.all(color: AppColors.borderColor),
                    validator: (value) =>
                        MyCustomValidator.validateIsEmpty(value),
                  ),
                  const SizedBox(height: 16),

                  InputWidget(
                    controller: _homeViewModel.phoneController.value,
                    isEnabled: true,
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    border: Border.all(color: AppColors.borderColor),
                    validator: (value) =>
                        MyCustomValidator.phoneNumberValidation(value),
                  ),

                  //Buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 19),
                    child: Container(
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFFFFFFF),
                          backgroundColor: AppColors.buttonBackgroundColor,
                          minimumSize: const Size(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {

                          final isValid = _homeViewModel.formKey.currentState!.validate();
                          Get.focusScope!.unfocus();

                          if (isValid) {
                            _homeViewModel.createCompanyAPI();
                          } else {
                            Utils.toastMessage(FORM_EMPTY_MESSAGE);
                          }
                        },
                        child: Text('Create a New Company',
                            style: Utils().getTextStyle(FontSizeManager.px16,
                                FontWeightManager.w700, Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  ListView buildListView() {
    return ListView.separated(
      itemCount: _homeViewModel.items.length,
      controller: _homeViewModel.scrollController,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        final CompanyItemModel item = _homeViewModel.items[index];
        return Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 30.0, left: 27),
          child: ListTile(
            title: Text(
              item.companyName.toString(),
              style: Utils().getTextStyle(
                  16, FontWeightManager.w600, AppColors.titleColor),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.email.toString(),
                  style: Utils().getTextStyle(
                      14, FontWeightManager.w400, AppColors.subTitleColor),
                ),
                Text(
                  item.email.toString(),
                  style: Utils().getTextStyle(
                      14, FontWeightManager.w400, AppColors.subTitleColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.3,
      title: Text(
        'Company List',
        style: Utils().getTextStyle(
            FontSizeManager.px18, FontWeightManager.w600, AppColors.titleColor),
      ),
    );
  }
}
