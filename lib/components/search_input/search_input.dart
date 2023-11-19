import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        hintText: 'Search...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: Colors.grey[900]!,
            width: 2,
          ),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            color: Colors.grey[900],
          ),
          padding: EdgeInsets.zero,
          child: GestureDetector(
            onTap: () {
              // Handle the submit button click
              String searchValue = _controller.text;
              // Do something with the search value
              print(searchValue);
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      // onChanged: (value) {
      //   // Do something with the search value
      //   print(value);
      // },
    );
  }
}
