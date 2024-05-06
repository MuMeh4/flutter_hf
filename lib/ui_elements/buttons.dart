import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const BlueButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21, left: 40, right: 40),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF08EBC2)),
          padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all(const Size(350, 58)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const WhiteButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21, left: 40, right: 40),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
          padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all(const Size(350, 58)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
