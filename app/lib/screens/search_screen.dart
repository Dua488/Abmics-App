import 'package:amlportal/controllers/search_comic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../customs/v_data_service.dart';
import '../customs/v_sizes.dart';
import '../models/comic_model.dart';
import '../widgets/comic_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;
    final refreshController = RefreshController(initialRefresh: true);
    final searchComicController = Get.put(SearchComicController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.green,
        title: Container(
          width: double.infinity,
          height: 45,
          child: SearchBar(
            backgroundColor: const MyColor(),
            onChanged: (word){
              searchComicController.showClearButton.value = word.isNotEmpty;
              refreshController.requestRefresh();
              /*
              if(word.isEmpty){
                refreshController.loadNoData();
                refreshController.requestRefresh();
              }
               */
            },
            controller: searchComicController.searchBarController,
            onSubmitted: (word) async {
              //await searchComicController.searchComic();
              refreshController.requestRefresh();
            },
            leading: const Icon(Icons.search),
            trailing: [
              // const Icon(Icons.send, color: Colors.blue,),
              Obx(
                    () => IconButton(
                    onPressed: () {
                      if (searchComicController.showClearButton.value) {
                        searchComicController.searchBarController.clear();
                        searchComicController.showClearButton.value = false;
                        searchComicController.searchComic();
                      } else {}
                    },
                    icon: searchComicController.showClearButton.value ? const Icon(Icons.clear) : const SizedBox(width: 0.1,)),
              )
            ],
          ),
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () async{
          await searchComicController.searchComic();
          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(VSizes.sm),
              child: Obx((){
                if (searchComicController.comicList.isEmpty){
                  return const SizedBox(height: 0.0,);
                }
                else{
                  return ListView.builder(
                      itemCount: searchComicController.comicList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(right: VSizes.xs),
                          child: ComicCard(comic: searchComicController.comicList[index], horizontal: false,),
                        );
                      });
                }
              })
          ),
        ),
      ),
    );
  }
}

class MyColor extends WidgetStateColor {
  const MyColor() : super(_defaultColor);

  static const int _defaultColor = 0xcafefeed;
  static const int _pressedColor = 0xdeadbeef;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}