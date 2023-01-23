import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop/widgets/item/item2.dart';

import 'package:shop/widgets/search/search_provider.dart';

class SearchItemListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building SearchItemListPage');

    return context.select<SearchProvider, bool>((sp) => sp.isDataFetched)
        ? Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Expanded(child: ListViewWidget()),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
  }
}

class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  String keye;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {}

  @override
  Widget build(BuildContext context) {
    final itemsPL =
        Provider.of<SearchProvider>(context, listen: false).getItems;
    //true because for reinitialization of the items List.(notifyListeners)

    print('Building ListViewWidget');
    return SmartRefresher(
        controller: _refreshController,
        enablePullUp: false,
        enablePullDown: false,
        onLoading: () => _onLoading(),
        child: ListView.builder(
            key: Key(keye),
            itemCount: itemsPL.length,
            itemBuilder: (_, index) {
              return Item2(item: itemsPL[index]);
            }));
  }
}
