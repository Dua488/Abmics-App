import 'dart:ui';
import 'package:amlportal/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/screens/container_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:dio/src/form_data.dart' as fd;

class VDataService extends GetxController {
  static VDataService get instance => Get.find();

  //final BASE_URL = 'https://aml-admin.mef.gov.kh/api/v1/external/';
  final BASE_URL = 'https://abmics.com/wp-admin/admin-ajax.php';

  final dio = Dio();

  final KEY_CURRENT_LANGUAGE = 'CURRENT_LANGUAGE';
  final KEY_USER_EMAIL = 'keyUserEmail';
  final KEY_USER_PWD = 'keyUserPwd';
  final KEY_IS_FAMILY_SAFE = 'keyIsFamilySafe';
  Locale currentLocal = Locale('km','KH');
  Locale kmLocal = Locale('km','KH');
  Locale enLocal = Locale('en','US');
  GetStorage box = GetStorage();
  //GetStorage box = GetStorage();
  RxBool isEnglish = true.obs;
  RxBool isFamilySafe = true.obs;
  //

  Rx<UserModel> user = UserModel.empty().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    FlutterNativeSplash.remove();
    //
    final isFamilySafe = box.read(KEY_IS_FAMILY_SAFE);
    if(isFamilySafe == null){
      this.isFamilySafe.value = true;
    }
    else{
      print("the family safe : ${isFamilySafe}");
      this.isFamilySafe.value = isFamilySafe;
    }
    //
    final strEmail = getUserEmail();
    final strPwd = getUserPwd();
    if(strEmail != null && strPwd != null &&strEmail.isNotEmpty && strPwd.isNotEmpty){
      final fdSignIn = fd.FormData.fromMap({
        'action': 'abcomics_get_user',
        'email': strEmail,
        'password': strPwd,
        'social' : 'none',
        'family_safe': isFamilySafe.value ? 'true' : 'false'
      });
      saveUser(strEmail, strPwd);
      final signInResponse = await requestData(fdSignIn);
      final signInUser = UserModel.fromJson(signInResponse['user']['data']);
      user.value = signInUser;
    }
    //
    Future.delayed(const Duration(seconds: 5)).then((val) {
      Get.offAll(()=> const ContainerScreen());
    });
  }

  Future<dynamic> requestData (fd.FormData formData) async {
    try{
      var header =  {"Accept": "application/json"};
      final response = await dio.post(BASE_URL,data: formData, options: Options(headers: header));
      print('response : ${response.statusCode}');
      print('response : ${response.data}');
      return response.data;
    }on DioException catch (e){
      print('dio code : ${e.response?.statusCode}');
      print('dio url : ${e.response?.realUri}');
      print('dio body : ${e.response?.data}');
      print('dio error : ${e.toString()}');
      print('dio message : ${e.message}');
      print('dio data : ${e.response?.data!}');
      VToast.showToastBar(title: isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
      throw e.message.toString();
    }
  }

  Future<bool> isUserLoggedIn() async {
    final userName = box.read(KEY_USER_EMAIL);
    final userPwd =  box.read(KEY_USER_PWD);
    return ((userName != null) && (userPwd != null));
  }

  setFamilySafe(bool isFamilySafe) async {
    print("is family safe : ${isFamilySafe}");
    box.write(KEY_IS_FAMILY_SAFE, isFamilySafe);
    this.isFamilySafe.value = isFamilySafe;
  }

  saveUser(String email, String pwd){
    box.write(KEY_USER_EMAIL, email);
    box.write(KEY_USER_PWD, pwd);
  }

  deleteUser(){
    box.remove(KEY_USER_EMAIL);
    box.remove(KEY_USER_PWD);
    user.value = UserModel.empty();
  }

  String? getUserEmail(){
    final userEmail = box.read(KEY_USER_EMAIL);
    return userEmail;
  }

  String? getUserPwd(){
    final userPwd = box.read(KEY_USER_PWD);
    return userPwd;
  }

}