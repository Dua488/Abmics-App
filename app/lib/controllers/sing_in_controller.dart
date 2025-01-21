

import 'package:amlportal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../customs/v_data_service.dart';
import '../customs/v_fullscreen_loader.dart';
import '../customs/v_network_manager.dart';
import '../customs/v_toast.dart';

import 'package:dio/src/form_data.dart' as fd;

class SignInController extends GetxController{
  static SignInController get instance => Get.find();
  final dataService = VDataService.instance;

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    email.text = localStorage.read('LOCAL_EMAIL') ?? '';
    password.text = localStorage.read('LOCAL_PWD') ?? '';
    super.onInit();
  }

  Future emailAndPasswordSignIn() async {
    VFullscreenLoader.openLoadingDialog();
    print('email : ${email.text.trim()}');
    print('pwd : ${password.text.trim()}');

    final strEmail = email.text.trim();
    final strPwd = password.text.trim();
    // final strEmail = 'viphu@gmail.com';
    // final strPwd = 'admin123';
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_user',
      'email': strEmail,
      'password': strPwd,
      'social' : 'none',
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false'
    });
    try{
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected){
        VToast.showToastBar(title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
        return;
      }
      if (!loginFormKey.currentState!.validate()){
        VFullscreenLoader.stopLoading();
        return;
      }

      final response = await dataService.requestData(formData);
      final user = UserModel.fromJson(response['user']['data']);
      dataService.user.value = user;
      //
      if(dataService.user.value.ID.isNotEmpty){
        dataService.saveUser(strEmail, strPwd);
      }
      //
      VFullscreenLoader.stopLoading();
      return;

    }catch (e){
      VFullscreenLoader.stopLoading();
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }

}