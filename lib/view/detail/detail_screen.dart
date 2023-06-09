import 'package:bahanku/view_model/commodity_controller.dart';
import 'package:bahanku/view/detail/widgets/category_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var categoryController = Get.put(CategoryController());

  final eEee = DateFormat.EEEE().format(DateTime.now());
  final d = DateFormat.d().format(DateTime.now());
  final yMmm = DateFormat.yMMMM().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Widget titleCard() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  eEee,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.sunny,
                  color: Colors.orangeAccent,
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '$d $yMmm',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      );
    }

    Widget categoriesCard() {
      return SizedBox(
        // padding: EdgeInsets.only(top: 20),
        height: 630,
        width: double.maxFinite,
        child: Obx(
          () {
            // ignore: unrelated_type_equality_checks
            if (categoryController.loading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: categoryController.mainCommodityList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: CategoryNew(
                      mainCommodity:
                          categoryController.mainCommodityList[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    // Widget contentPage() {
    return Column(
      children: [
        titleCard(),
        categoriesCard(),
      ],
    );
    // }

    // return Scaffold(
    //   body: contentPage(),
    // );
  }
}
