
import '../network/app_urls.dart';
import '../network/network_api_services.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getStudentListAPI(String url) async {
    var response = _apiService.getApi(url);
    return response;
  }


  Future<dynamic> createNewCompany(var data) async {
    var response = _apiService.postApi(AppUrls.COMPANY_API_STRING,data);
    return response;
  }


}
