import 'package:apex_assessment/models/home/company_list_response.dart';
import 'package:apex_assessment/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/home/create_new_company_response.dart';
import '../../network/app_urls.dart';
import '../../resources/status.dart';
import '../../resources/utils.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  ScrollController scrollController = ScrollController();

  final items = <CompanyItemModel>[].obs;
  final rxRequestStatus = ApiStatus.loading.obs;

  String? nextUrl;
  RxString error = ''.obs;

  var companyNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>();


  void setRxRequestStatus(ApiStatus status) => rxRequestStatus.value = status;
  void setError(String _value) => error.value = _value;

  RxBool isCreateLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllCompanyList(AppUrls.COMPANY_API_STRING);
    scrollController.addListener(_scrollListener);
  }

  fetchAllCompanyList(String url) {
    _homeRepository.getStudentListAPI(url).then((value) {
      setRxRequestStatus(ApiStatus.completed);

      var companyListResponse = CompanyListResponse.fromJson(value);
      nextUrl = companyListResponse.companyList?.nextPageUrl.toString();
      companyListResponse.companyList?.data?.forEach((item) {
        items.add(item);
      });
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(ApiStatus.error);
    });
  }

  refreshUI() {
    items.clear();
    items.refresh();
    setRxRequestStatus(ApiStatus.loading);
    fetchAllCompanyList(AppUrls.COMPANY_API_STRING);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (nextUrl != null && nextUrl != 'null') {
        fetchAllCompanyList(nextUrl!);
      } else {
        if (kDebugMode) {
          print(nextUrl);
        }
      }
    }
  }

  clearTextFields(){
    companyNameController.value.text = '';
    emailController.value.text = '';
    phoneController.value.text = '';
    passwordController.value.text = '';
  }

  void createCompanyAPI() {
    isCreateLoading.value = true;
    var data = {
      "company_name": companyNameController.value.text,
      "email": emailController.value.text,
      "password": passwordController.value.text,
      "phone": phoneController.value.text
    };
    _homeRepository.createNewCompany(data).then((value) {
      isCreateLoading.value = false;

      if(value['status_code'] == '1'){
        var createNewCompanyResponse = CreateNewCompanyResponse.fromJson(value);
        Get.back();
        refreshUI();
        Utils.snackBar('Success!', createNewCompanyResponse.statusMessage.toString());
        clearTextFields();


      }else{
        var createNewCompanyResponse = CreateNewCompanyResponse.fromJson(value);
        Utils.successSnackBar('Error!', createNewCompanyResponse.statusMessage.toString());

      }

    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(ApiStatus.error);
    });
  }
}
