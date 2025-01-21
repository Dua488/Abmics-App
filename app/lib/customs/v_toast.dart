import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VToast{

  static showToastBar({required title, message = '', duration = 5, error = false}){

    final color = error ? Colors.deepOrangeAccent : Colors.blue;

    Get.snackbar(title, message,
        duration: Duration(seconds: duration),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: color,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.info,
          color: Colors.white,
        ));
  }
}