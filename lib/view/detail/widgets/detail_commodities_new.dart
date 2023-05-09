import 'package:flutter/material.dart';

import '../../../models/commodity/main_commodity.dart';
import 'price.dart';

class DetailsCommodityNew extends StatelessWidget {
  const DetailsCommodityNew({
    super.key,
    required this.abcCommodity,
  });
  final MainCommodity abcCommodity;

  @override
  Widget build(BuildContext context) {
    Widget descCommodity() {
      return Container(
        width: double.maxFinite,
        height: 70,
        decoration: const BoxDecoration(
          // color: Colors.amber[200],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  abcCommodity.calorie,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Kalori',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  abcCommodity.carbo,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Karbohidrat',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  abcCommodity.protein,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Protein',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         SizedBox(
        //           width: 70,
        //           child: Text(abcCommodity.calorie,
        //               style: TextStyle(fontSize: 16)),
        //         ),
        //         SizedBox(
        //           width: 70,
        //           child: Text(abcCommodity.carbo,
        //               style: TextStyle(fontSize: 16)),
        //         ),
        //         SizedBox(
        //           width: 70,
        //           child: Text(abcCommodity.protein,
        //               style: TextStyle(fontSize: 16)),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 5),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         SizedBox(
        //           width: 60,
        //           child: Text('Kalori',
        //               style:
        //                   TextStyle(color: Colors.grey[500], fontSize: 16)),
        //         ),
        //         SizedBox(
        //           width: 80,
        //           child: Text('Karbohidrat',
        //               style:
        //                   TextStyle(color: Colors.grey[500], fontSize: 16)),
        //         ),
        //         SizedBox(
        //           width: 60,
        //           child: Text('Protein',
        //               style:
        //                   TextStyle(color: Colors.grey[500], fontSize: 16)),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      );
    }

    Widget shortedBy() {
      return Container(
        margin: const EdgeInsets.only(left: 15),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Harga :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                const PopupMenuItem(value: '', child: Text('Highest Price')),
                const PopupMenuItem(value: '', child: Text('Lowest Price'))
              ],
              child: Image.asset(
                'assets/icons/shorted-by.png',
                scale: 1.1,
              ),
            )
          ],
        ),
      );
    }

    Widget priceCommodity() {
      return Container(
        padding: const EdgeInsets.only(bottom: 20),
        width: double.maxFinite,
        height: 400,
        decoration: const BoxDecoration(),
        child: ListView(
            children: abcCommodity.details
                .map((item) => Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Price(
                        detailCommodity: item,
                      ),
                    ))
                .toList()),
      );
    }

    Widget columnDetails() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // imageCommodity(),
            descCommodity(),
            shortedBy(),
            priceCommodity(),
          ],
        ),
      );
    }

    return columnDetails();
  }
}
