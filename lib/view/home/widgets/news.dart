import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({
    Key? key,
    required this.image,
    required this.media,
    required this.title,
    required this.time,
  }) : super(key: key);

  final String image;
  final String media;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          Container(
            width: 240,
            height: 267,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          // Image.asset(
          //   image,
          //   width: 300,
          // ),
          Positioned(
            top: 125,
            left: 15,
            child: Container(
              width: 210,
              height: 125,
              padding: const EdgeInsets.all(15),
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
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        media,
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                      Text(
                        time,
                        style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
