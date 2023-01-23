import 'package:flutter/material.dart';
import 'package:shop/widgets/search/search_provider.dart';
import 'package:provider/provider.dart';

class SearchCustomTextField extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  void onChanged(String input, BuildContext context) {
    if (input.isEmpty) {
      context.read<SearchProvider>().changeIsTextFieldEmpty(true);
    } else {
      context.read<SearchProvider>().changeIsTextFieldEmpty(false);
    }
    if (input.length >= 3) {
      context.read<SearchProvider>().getSuggestions(input);
    } else {
      context.read<SearchProvider>().clearSuggestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building SearchCustomTextField');
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8),
          border: Border.all()),
      child: TextField(
        onTap: () {
          context.read<SearchProvider>().isDataFetched = false;
          context.read<SearchProvider>().changeIsSearching(to: true);
        },
        onChanged: (input) => onChanged(input, context),
        autofocus: true,
        focusNode: FocusNode(),
        controller: context.read<SearchProvider>().textEditingController,
        style: TextStyle(
            fontSize: 19,
            height: 1,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
          hintText: 'search items',
          hintStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 18),
        ),
        cursorColor: Colors.blue,
        cursorHeight: 30,
      ),
    );
  }
}
