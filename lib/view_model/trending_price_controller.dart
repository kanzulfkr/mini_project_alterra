import 'dart:convert';
import 'package:bahanku/api/network_handler.dart';
import 'package:bahanku/models/trending_price/main_trending_price.dart';
import 'package:bahanku/models/trending_price/super_trending_price.dart';
import 'package:get/get.dart';

class TrendingPriceController extends GetxController {
  RxBool loading = false.obs;
  List<MainTrendingPrice> mainTrendingPriceList = [];

  // SuperTrendingPrice? superTrendingPrice;
  // List<DetailTrendingPrice> detailTrendingPriceList = [];

  @override
  void onInit() {
    super.onInit();
    getTrendingPrice();
  }

  void getTrendingPrice() async {
    loading(true);
    var response =
        await NetWorkHandler.get("/c5ea244c-bc16-414d-9400-1792def88ad5", "");
    mainTrendingPriceList =
        SuperTrendingPrice.fromJson(json.decode(response)).data;
    loading(false);
  }
}
