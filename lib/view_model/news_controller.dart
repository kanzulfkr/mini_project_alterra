import 'dart:convert';

import 'package:bahanku/models/news/main_news.dart';
import 'package:bahanku/api/network_handler.dart';
import 'package:bahanku/models/news/super_news.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  RxBool loading = false.obs;
  List<MainNewss> mainNewsList = [];

  // SuperNews? superNews;
  // List<DetailNews> detailNewsList = [];

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  void getNews() async {
    loading(true);
    var response =
        await NetWorkHandler.get("/fba9f2dd-7ee6-487a-a099-19026ab3ae82", "");
    mainNewsList = SuperNewss.fromJson(json.decode(response)).data;
    loading(false);
  }
}
