import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../customs/v_data_service.dart';
import '../customs/v_network_manager.dart';
import '../customs/v_toast.dart';
import '../models/comic_model.dart';
import 'package:dio/src/form_data.dart' as fd;

class SearchComicController extends GetxController{
  static SearchComicController get instance => Get.find();
  final dataService = VDataService.instance;
  final searchBarController = TextEditingController();
  RxList<ComicModel> comicList = <ComicModel>[].obs;
  RxBool showClearButton = false.obs;
  RxList<ComicModel> filteredComics = <ComicModel>[].obs; // Filtered results
  RxString searchQuery = ''.obs; // Current search query


  @override
  void onInit() {
    super.onInit();
    searchQuery.value = '';}


  searchComic() async{
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_search',
      's': searchBarController.value.text,
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false'
    });
    try{
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected){
        VToast.showToastBar(title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
        return;
      }
      final response = await dataService.requestData(formData);
      final dataList = response['data']['items'] as List;
      //
      print('number of comic page : ${response['data']['paged'].toString()}');
      print('number of comic totla : ${response['data']['total'].toString()}');
      //
      final allList = dataList.map((item) => ComicModel.fromJson(item)).toList();
      comicList.assignAll(allList);
      print('number of comic : ${comicList.length}');

    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }


  // Filter comics based on search query
  void filterComics() {
    if (searchQuery.value.isEmpty) {
      // Show default results if search query is empty
      filteredComics.value = comicList;
    } else {
      // Filter comics by matching titles
      filteredComics.value = comicList
          .where((comic) => comic.title_en


          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }
}