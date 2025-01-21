import 'dart:async';
import 'v_toast.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class VNetworkManager extends GetxController {
  static VNetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;


  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    for (final r in result){
      print('check internet connection : ${r.toString()}');
    }
    if (result.contains(ConnectivityResult.none) ){
      VToast.showToastBar(title: 'មិនមានអ៊ីនធើណិត', message: 'សូមពិនិត្យការតភ្ជាប់អ៊ីនធើណិតរបស់អ្នក');
      _connectionStatus = ConnectivityResult.none as Rx<ConnectivityResult>;
    }

  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status ${e.toString()}');
      VToast.showToastBar(title: 'មិនមានអ៊ីនធើណិត', message: 'សូមពិនិត្យ${e.toString()}');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    return _updateConnectionStatus(result);
  }
  Future<bool> isConnected() async {
    try{
      final result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)){
        return false;
      }
      else {
        return true;
      }
    } on PlatformException catch (_){
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}