import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_network_manager.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as fd;

class HomeController extends GetxController{
  final dataService = VDataService.instance;
  RxList<ComicModel> recentComicList = <ComicModel>[].obs;
  RxList<ComicModel> popularComicList = <ComicModel>[].obs;
  RxList<ComicModel> carouselList = <ComicModel>[].obs;
  RxInt carouselIndex = 0.obs;



  refreshHome() async {
    await getCarousel();
    await getRecentComicList();
    await getPopularComicList();
  }

  getRecentComicList() async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_comics',
      'type': 'recently',
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

      final allList = dataList.map((item) => ComicModel.fromJson(item)).toList();
      recentComicList.assignAll(allList);
      
    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }

  getPopularComicList() async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_comics',
      'type': 'popular',
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

      final allList = dataList.map((item) => ComicModel.fromJson(item)).toList();
      print("popular list : ${allList.length}");
      popularComicList.assignAll(allList);

    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }

  getCarousel() async{
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_carousel',
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
      final allList = dataList.map((item) => ComicModel.fromJson(item)).toList();
      carouselList.assignAll(allList);
      print('carousel : ${carouselList.length}');
    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }
}

