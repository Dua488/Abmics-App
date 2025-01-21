import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_network_manager.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/models/genre_model.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as fd;

class GenreController extends GetxController{
  final dataService = VDataService.instance;
  RxList<GenreModel> slugList = <GenreModel>[].obs;
  RxInt selectedIndex = 0.obs;

  RxList<ComicModel> comicList = <ComicModel>[].obs;
  var paged = '0';


  getGenre() async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_genre',
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false'
    });
    try{
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected){
        VToast.showToastBar(title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
        return;
      }
      final response = await dataService.requestData(formData);
      final dataList = response['data'] as List;

      final allList = dataList.map((item) => GenreModel.fromJson(item)).toList();
      print('from server count : ${allList.length}');
      slugList.assignAll(allList);
      await getComicBySlug(false);

    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }

  getComicBySlug(bool isLoadMore) async {

    if(isLoadMore){
      paged = (int.parse(paged)+1).toString();
    }
    else{
      paged = '0';
    }
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_comics',
      'genre': slugList[selectedIndex.value].slug,
      'paged': paged,
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
      print('from server count : ${allList.length}');

      if(isLoadMore){
        final old = comicList;
        final combind = allList+old;
        //comicList.assignAll(combind);
        print('load more !!!');
        comicList.addAll(allList);
      }
      else{
        comicList.assignAll(allList);
      }
      print('number of comic : ${comicList.length}');

    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }
}