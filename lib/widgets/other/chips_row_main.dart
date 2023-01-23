import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/chips_tab_provider.dart';
import 'package:shop/widgets/other/custom_chips.dart';

class ChipsRow extends StatelessWidget {
  final List<String> chipsLabels;

  ChipsRow({@required this.chipsLabels});
  @override
  Widget build(BuildContext context) {
    print('building ChipsRow');

    var selectedIndex =
        context.select((ChipsTabProvider ctp) => ctp.getselectedIndex);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List<Widget>.generate(
            chipsLabels.length,
            (int index) {
              return CustomChip(
                label: chipsLabels[index],
                selectedChipIndex: selectedIndex,
                chipIndex: index,
              );
            },
          ),
        ],
      ),
    );
  }
}
