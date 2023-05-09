import 'dart:convert';
import 'package:bahanku/models/commodity/main_commodity.dart';
import 'package:bahanku/models/commodity/super_commodity.dart';
import 'package:bahanku/api/network_handler.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxBool loading = false.obs;
  List<MainCommodity> mainCommodityList = [];

  // SuperCommodity? superCommodity;
  // List<DetailCommodity> detailCommodityList = [];

  @override
  void onInit() {
    super.onInit();
    getCommodity();
  }

  void getCommodity() async {
    loading(true);
    var response =
        await NetWorkHandler.get("/d891d857-a67c-46c6-8843-5e63e8122673", "");
    mainCommodityList = SuperCommodity.fromJson(json.decode(response)).data;
    loading(false);
  }
}
