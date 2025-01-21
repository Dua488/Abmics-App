import 'dart:async';
import 'package:amlportal/customs/v_data_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';



Future <void> main () async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(VDataService());
  runApp(const App());
}