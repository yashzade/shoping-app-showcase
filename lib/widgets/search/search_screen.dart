import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/widgets/search/search_provider.dart';
import 'package:shop/widgets/search/search_custom_text_field.dart';
import 'package:shop/widgets/search/result_search_screen.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/searchScreen';
  // Get average runtime of successful runs in seconds

  @override
  Widget build(BuildContext context) {
    print('building SearchScreen.....');

    return Scaffold(
        backgroundColor: Colors.black,

        // bottomNavigationBar: ,
        appBar: AppBar(
          leading: backButton(context),
          actions: [
            Selector<SearchProvider, bool>(
              selector: (ctx, sp) => sp.isFieldhasValue,
              builder: (_, isFieldhasValue, __) {
                return isFieldhasValue
                    ? Padding(
                        //mic icon button
                        padding: EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: () => null,
                          color: Colors.grey,
                        ),
                      )
                    : Padding(
                        //clear icon button
                        padding: EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            context.read<SearchProvider>().clearTextfield();
                            FocusManager.instance.primaryFocus.requestFocus();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        ),
                      );
              },
            ),
          ],
          title: SearchCustomTextField(),
        ),
        body: ResultSearchScreen());
  }

  IconButton backButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.grey,
        onPressed: () async {
          FocusManager.instance.primaryFocus.unfocus();
          await Future.delayed(Duration(milliseconds: 200));

          Navigator.of(context).popUntil((route) {
            print(route.settings);
            return route.settings.name == "home";
          });
        });
  }
}
