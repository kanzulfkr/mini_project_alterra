import 'package:bahanku/view_model/news_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsSlider extends StatefulWidget {
  const NewsSlider({super.key});

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  var newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
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
                              newsController.mainNewsList[index].time,
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
              autoPlayCurve: Curves.easeInOutCirc,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 0.845,
              height: 220,
              enableInfiniteScroll: false,
              initialPage: 2,
              autoPlay: true,
              enlargeCenterPage: true),
        );
      },
    );
  }
}
