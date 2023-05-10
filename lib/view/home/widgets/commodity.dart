import 'package:bahanku/models/trending_price/details_trending_price.dart';
import 'package:flutter/material.dart';

class Commodity extends StatelessWidget {
  const Commodity({
    Key? key,
    required this.detailTrendingPrice,
  }) : super(key: key);

  final DetailTrendingPrice detailTrendingPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, spreadRadius: 1),
        ],
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/commodities/${detailTrendingPrice.image}',
                width: 100,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailTrendingPrice.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    detailTrendingPrice.price,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/icons/${detailTrendingPrice.indicatorprice}',
                  cacheHeight: 20,
                  cacheWidth: 20,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    detailTrendingPrice.time,
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '${detailTrendingPrice.percent} %     ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
