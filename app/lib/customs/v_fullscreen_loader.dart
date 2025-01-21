import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VFullscreenLoader{
  static void openLoadingDialog(){
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: Colors.blue[900]!.withOpacity(0.2),
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                  child: Image(image: AssetImage('assets/loading.gif'))),
            )));
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}