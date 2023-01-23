import 'package:flutter/material.dart';
import 'package:shop/widgets/search/search_provider.dart';
import 'package:provider/provider.dart';

class SearchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> autoCompleteResults =
        context.select((SearchProvider sp) => sp.autoCompleteResults);
    print('Building SearchingPage');
    return ListView.builder(
      itemCount: autoCompleteResults.length,
      itemBuilder: (_, i) {
        return ListTile(
          onTap: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 300));
            context.read<SearchProvider>().changeIsSearching(to: false);
            context
                .read<SearchProvider>()
                .searchQuery(searchQuery: autoCompleteResults[i]);
          },
          trailing: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          title: Text(
            autoCompleteResults[i],
            style: TextStyle(color: Colors.white),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
        );
      },
    );
  }
}
