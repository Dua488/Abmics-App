import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_network_manager.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as fd;

class EpisodeController extends GetxController{
  final dataService = VDataService.instance;
  RxList<EpisodeModel> episodeList = <EpisodeModel>[].obs;

  getEpisodeByComicId(String comicId) async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_episodes_by_comic_id',
      'comic_id': comicId,
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
      //
      final allList = dataList.map((item) => EpisodeModel.fromJson(item)).toList();
      print('from server count : ${allList.length}');

      episodeList.assignAll(allList);
      print('number of comic : ${episodeList.length}');

    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }
}