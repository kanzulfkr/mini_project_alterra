// ignore_for_file: unrelated_type_equality_checks

import 'package:bahanku/view_model/news_controller.dart';
import 'package:bahanku/view_model/trending_price_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'widgets/commodity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var newsController = Get.put(NewsController());
  var trendingPriceController = Get.put(TrendingPriceController());
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);

    String getGreeting() {
      var timeNow = DateTime.now().hour;
      if ((timeNow < 12) && (timeNow >= 6)) {
        return 'Good norning';
      } else if ((timeNow >= 12) && (timeNow <= 15)) {
        return 'Good afternoon';
      } else if ((timeNow > 16) && (timeNow < 18)) {
        return 'Good evening';
      } else {
        return 'Good night';
      }
    }

    Widget headerWidget() {
      return Container(
        width: double.maxFinite,
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              getGreeting(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            // const Icon(
            //   Icons.cloud_queue_outlined,
            //   color: Colors.white,
            // )
          ],
        ),
      );
    }

    Widget newsSlider() {
      return Obx(
        () {
          if (newsController.loading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CarouselSlider.builder(
            itemCount: newsController.mainNewsList.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: 325,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   '${newsController.mainNewsList[index].image}',
                  //   width: 300,
                  //   height: 220,
                  //   fit: BoxFit.fill,
                  // ),
                  Positioned(
                    top: 115.0,
                    left: 27.5,
                    child: Container(
                      width: 270,
                      height: 90,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            newsController.mainNewsList[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newsController.mainNewsList[index].namewebsite,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.blueAccent),
                              ),
                              Text(
                                newsController.mainNewsList[index].lokasi,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
                autoPlayCurve: Curves.ease,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.845,
                height: 220,
                enableInfiniteScroll: false,
                // initialPage: 2,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.17),
          );
        },
      );
    }

    Widget trendingPrice() {
      return Obx(
        () {
          if (trendingPriceController.loading == true) {
            return Column(
              children: const [
                SizedBox(height: 150),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                  child: Text(
                    'Trending price',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: TabBar(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    controller: tabController,
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.grey[400],
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: trendingPriceController
                            .mainTrendingPriceList[1].name,
                      ),
                      Tab(
                        text: trendingPriceController
                            .mainTrendingPriceList[2].name,
                      ),
                      Tab(
                        text: trendingPriceController
                            .mainTrendingPriceList[0].name,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 355,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Tab(
                        child: ListView(
                          children: trendingPriceController
                              .mainTrendingPriceList[0].details
                              .map(
                                (item) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Commodity(
                                    detailTrendingPrice: item,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Tab(
                        child: ListView(
                          children: trendingPriceController
                              .mainTrendingPriceList[1].details
                              .map(
                                (item) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Commodity(
                                    detailTrendingPrice: item,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Tab(
                        child: ListView(
                          children: trendingPriceController
                              .mainTrendingPriceList[2].details
                              .map(
                                (item) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Commodity(
                                    detailTrendingPrice: item,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
      // return Container(
      //   width: double.maxFinite,
      //   height: 400,
      //   color: Colors.red,
      // );
    }

    return ListView(
      children: [
        Container(
          color: Colors.grey.shade200,
          height: 815,
          child: Stack(
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headerWidget(),
                  newsSlider(),
                  const SizedBox(
                    height: 20,
                  ),
                  trendingPrice(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
