import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/chips_tab_provider.dart';
import 'package:shop/providers/products_provider.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final int selectedChipIndex, chipIndex;

  CustomChip({
    @required this.label,
    @required this.selectedChipIndex,
    @required this.chipIndex,
  });
  @override
  Widget build(BuildContext context) {
    print('building CustomChips');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: FilterChip(
        side: selectedChipIndex == chipIndex
            ? BorderSide(color: Colors.white)
            : BorderSide(color: Colors.grey[850]),
        onSelected: (_) => onSelected(context),
        label: Text('$label'),
        labelStyle: TextStyle(
            color: chipIndex == selectedChipIndex
                ? Theme.of(context).chipTheme.labelStyle.color
                : Theme.of(context).chipTheme.secondaryLabelStyle.color),
        selected: chipIndex == selectedChipIndex,
      ),
    );
  }

  void onSelected(BuildContext context) async {
    if (selectedChipIndex != chipIndex) {
      await context
          .read<ProductsProvider>()
          .fetchAndSetProducts2(searchQuery: label);
      context.read<ChipsTabProvider>().changeSelectedIndex(chipIndex);
      //1st fetch,then change chips label
    }
  }
}
