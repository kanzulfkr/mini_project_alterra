import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  const ButtonWidgets({
    Key? key,
    required this.nameButton,
    required this.iconButton,
  }) : super(key: key);

  final String nameButton;
  final String iconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.maxFinite,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(iconButton),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: 220,
              child: Text(
                nameButton,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Image.asset('assets/icons/next.png'),
          ],
        ),
      ),
    );
  }
}
