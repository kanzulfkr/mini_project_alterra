import 'package:flutter/material.dart';

class Commodity extends StatelessWidget {
  const Commodity({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String image;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, left: 20),
      child: SizedBox(
        width: double.maxFinite,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8.0),
            //   child: Image.asset(
            //     image,
            //     width: 100,
            //     height: 80,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(width: 20),
            SizedBox(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '$price/kg',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(''),
                  const SizedBox(height: 15),
                  Text(
                    '$price/kg',
                    style: TextStyle(fontSize: 16, color: Colors.grey[400]),
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
