import 'package:flutter/material.dart';

import '../../../models/commodity/details_commodity.dart';

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.detailCommodity,
  });
  final DetailCommodity detailCommodity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              detailCommodity.name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Text(
            '${detailCommodity.display} /kg',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
