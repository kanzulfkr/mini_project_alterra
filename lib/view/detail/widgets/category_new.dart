import 'package:flutter/material.dart';

import '../../../models/commodity/main_commodity.dart';
import 'detail_commodities_new.dart';

class CategoryNew extends StatelessWidget {
  const CategoryNew({super.key, required this.mainCommodity});
  final MainCommodity mainCommodity;

  @override
  Widget build(BuildContext context) {
    // yang lama
    // print('assets/images/commodities/${mainCommodity.thumbnail}');
    Widget yangLama() {
      return ExpansionTile(
        textColor: Colors.black,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/images/commodities/${mainCommodity.thumbnail}',
                        fit: BoxFit.contain,
                        // scale: 0.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      // width: 200,
                      child: Text(
                        mainCommodity.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            mainCommodity.lowestprice,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 20),
                          child: Image.asset(
                            'assets/icons/right-left.png',
                          ),
                        ),
                        Text(
                          mainCommodity.highestprice,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // trailing: SizedBox.shrink(),
        children: [
          DetailsCommodityNew(abcCommodity: mainCommodity),
        ],
      );
    }

    return yangLama();
  }
}
