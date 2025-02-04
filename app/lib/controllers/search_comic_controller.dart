import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../customs/v_data_service.dart';
import '../customs/v_network_manager.dart';
import '../customs/v_toast.dart';
import '../models/comic_model.dart';
import 'package:dio/src/form_data.dart' as fd;

class SearchComicController extends GetxController {
  static SearchComicController get instance => Get.find();
  final dataService = VDataService.instance;
  final searchBarController = TextEditingController();

  RxList<ComicModel> comicList = <ComicModel>[].obs;
  RxList<ComicModel> filteredComics = <ComicModel>[].obs; // Filtered results
  RxBool showClearButton = false.obs;
  RxString searchQuery = ''.obs; // Current search query

  @override
  void onInit() {
    super.onInit();
    searchQuery.value = '';

    // Attach listener to search bar controller
    searchBarController.addListener(() {
      searchQuery.value = searchBarController.text;
    });

    // Auto-filter comics when searchQuery changes
    ever(searchQuery, (_) => filterComics());
  }

  Future<void> searchComic() async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_search',
      's': searchQuery.value,
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false',
    });

    try {
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected) {
        VToast.showToastBar(
          title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت',
          message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك',
          error: true,
        );
        return;
      }

      final response = await dataService.requestData(formData);
      final dataList = response['data']['items'] as List;

      print('Number of comic pages: ${response['data']['paged']}');
      print('Total comics found: ${response['data']['total']}');

      comicList.assignAll(dataList.map((item) => ComicModel.fromJson(item)).toList());
      print('Number of comics: ${comicList.length}');

      // Refresh filtered list
      filterComics();
    } catch (e) {
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }

  void filterComics() {
    if (searchQuery.value.isEmpty) {
      filteredComics.assignAll(comicList);
    } else {
      filteredComics.assignAll(
        comicList.where((comic) => comic.title_en.toLowerCase().contains(searchQuery.value.toLowerCase())).toList(),
      );
    }
  }

  @override
  void onClose() {
    searchBarController.dispose();
    super.onClose();
  }
}
