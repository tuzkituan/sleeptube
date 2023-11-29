import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final void Function()? onTap;
  final String? label;
  const Tag({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(27),
      ),
      alignment: Alignment.center,
      child: Text(
        label ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}
