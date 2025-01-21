

import 'package:amlportal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../customs/v_data_service.dart';
import '../customs/v_fullscreen_loader.dart';
import '../customs/v_network_manager.dart';
import '../customs/v_toast.dart';

import 'package:dio/src/form_data.dart' as fd;

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance => Get.find();
  final dataService = VDataService.instance;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    email.text = localStorage.read('LOCAL_EMAIL') ?? '';
    super.onInit();
  }

  Future<bool> forgotPassword() async {
    VFullscreenLoader.openLoadingDialog();
    print('email : ${email.text.trim()}');
    final strEmail = email.text.trim();
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_lost_password',
      'email': strEmail,
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false'
    });
    try{
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected){
        VToast.showToastBar(title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
        return false;
      }
      if (!forgotPasswordFormKey.currentState!.validate()){
        VFullscreenLoader.stopLoading();
        return false;
      }

      final response = await dataService.requestData(formData);
      //
      VFullscreenLoader.stopLoading();
      if((response['success'] as bool) == true){
        VToast.showToastBar(title: 'Forgot Password', message: response['message'].toString());
        return true;
      }
      else{
        VToast.showToastBar(title: 'Forgot Password', message: response['message'].toString(), error: true);
        return false;
      }
    }catch (e){
      VFullscreenLoader.stopLoading();
      VToast.showToastBar(title: e.toString(), error: true);
      return false;
    }
  }

}