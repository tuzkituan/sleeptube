import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final void Function(String)? onFinish;
  final TextEditingController controller;

  SearchInput({Key? key, required this.controller, this.onFinish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        hintText: 'Search...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.grey[900],
          ),
          padding: EdgeInsets.zero,
          child: GestureDetector(
            onTap: () {
              String searchValue = controller.text;
              controller.text = searchValue;
              onFinish!(searchValue);
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      onSubmitted: (String value) {
        controller.text = value;
        onFinish!(value);
      },
    );
  }
}
