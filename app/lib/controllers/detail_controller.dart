import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_network_manager.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/models/detail_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:dio/src/form_data.dart' as fd;

class DetailController extends GetxController{
  final dataService = VDataService.instance;
  Rx<DetailModel> detail = DetailModel.empty().obs;

  getDetailByEpisodeId(String episodeId) async {
    final formData = fd.FormData.fromMap({
      'action': 'abcomics_get_episode_by_id',
      'episode_id': episodeId,
      'family_safe': dataService.isFamilySafe.value ? 'true' : 'false'
    });
    try{
      final isConnected = await VNetworkManager.instance.isConnected();
      if (!isConnected){
        VToast.showToastBar(title: dataService.isEnglish.value ? 'Internet Problem' : 'مشكلة الانترنت', message: dataService.isEnglish.value ? 'Check your connection' : 'التحقق من اتصالك', error: true);
        return;
      }
      final response = await dataService.requestData(formData);
      final dataList = response['data'];
      //
      final allList = DetailModel.fromJson(dataList);
      detail.value = allList;
    }catch (e){
      VToast.showToastBar(title: e.toString(), error: true);
    }
  }
}