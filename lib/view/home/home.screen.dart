import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'widgets/commodity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);

    String getGreeting() {
      var timeNow = DateTime.now().hour;
      if ((timeNow < 12) && (timeNow >= 6)) {
        return 'Good norning, ';
      } else if ((timeNow >= 12) && (timeNow <= 15)) {
        return 'Good afternoon, ';
      } else if ((timeNow > 16) && (timeNow < 18)) {
        return 'Good evening, ';
      } else {
        return 'Good night, ';
      }
    }

    Widget headerWidget() {
      return Container(
        width: double.maxFinite,
        height: 120,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(
          children: [
            Text(
              '${getGreeting()}',
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

    Widget articleSlider() {
      return CarouselSlider.builder(
        itemCount: 5,
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
              //   'assets/images/gibran.jfif',
              //   width: 300,
              // ),
              Positioned(
                top: 115.0,
                left: 27.5,
                child: Container(
                  width: 270,
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Walikota : kenaikan harga cabai karena pupuk yang langka',
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Tribun News',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blueAccent),
                          ),
                          Text(
                            '56 menit',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
          autoPlayInterval: const Duration(seconds: 4),
          viewportFraction: 0.845,
          height: 220,
          enableInfiniteScroll: false,
          initialPage: 2,
          autoPlay: true,
        ),
      );
    }

    Widget trendingPrice() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Trending price',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              height: 50,
              child: TabBar(
                controller: tabController,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey[400],
                tabs: const [
                  Tab(text: 'Jawa Timur'),
                  Tab(text: 'Bali'),
                  Tab(text: 'Maluku'),
                  Tab(text: 'Banten')
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 345,
              child: TabBarView(
                controller: tabController,
                children: [
                  Tab(
                    child: Column(
                      children: const [
                        Commodity(
                          image: 'assets/images/daging-ayam.jfif',
                          title: 'Daging Ayam',
                          price: 'Rp. 30.500',
                        ),
                        Commodity(
                          image: 'assets/images/daging-sapi.jfif',
                          title: 'Daging Sapi',
                          price: 'Rp. 110.900',
                        ),
                        Commodity(
                          image: 'assets/images/bawang-putih.jfif',
                          title: 'Bawang Putih',
                          price: 'Rp. 40.000',
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: const [
                        Commodity(
                          image: 'assets/images/daging-sapi.jfif',
                          title: 'Daging Sapi',
                          price: 'Rp. 110.900',
                        ),
                        Commodity(
                          image: 'assets/images/bawang-putih.jfif',
                          title: 'Bawang Putih',
                          price: 'Rp. 40.000',
                        ),
                        Commodity(
                          image: 'assets/images/daging-ayam.jfif',
                          title: 'Daging Ayam',
                          price: 'Rp. 30.500',
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: const [
                        Commodity(
                          image: 'assets/images/bawang-putih.jfif',
                          title: 'Bawang Putih',
                          price: 'Rp. 40.000',
                        ),
                        Commodity(
                          image: 'assets/images/daging-sapi.jfif',
                          title: 'Daging Sapi',
                          price: 'Rp. 110.900',
                        ),
                        Commodity(
                          image: 'assets/images/daging-ayam.jfif',
                          title: 'Daging Ayam',
                          price: 'Rp. 30.500',
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: const [
                        Commodity(
                          image: 'assets/images/daging-sapi.jfif',
                          title: 'Daging Sapi',
                          price: 'Rp. 110.900',
                        ),
                        Commodity(
                          image: 'assets/images/bawang-putih.jfif',
                          title: 'Bawang Putih',
                          price: 'Rp. 40.000',
                        ),
                        Commodity(
                          image: 'assets/images/daging-ayam.jfif',
                          title: 'Daging Ayam',
                          price: 'Rp. 30.500',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          height: 370,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headerWidget(),
                  articleSlider(),
                ],
              ),
            ],
          ),
        ),
        trendingPrice(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
