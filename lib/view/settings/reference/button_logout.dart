import 'package:flutter/material.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({
    Key? key,
    required this.nameButton,
  }) : super(key: key);

  final String nameButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.maxFinite,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            nameButton,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
