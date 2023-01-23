import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/widgets/bottom_login_signup/authentication_provider.dart';

class BLSCustomChips extends StatelessWidget {
  final String label;
  final int selectedChipIndex, chipIndex;

  BLSCustomChips({
    @required this.label,
    @required this.selectedChipIndex,
    @required this.chipIndex,
  });
  @override
  Widget build(BuildContext context) {
    print('building BLSCustomChips');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: FilterChip(
        selectedColor: Colors.blue,
        backgroundColor: Colors.grey[350],
        shadowColor: Colors.black,
        elevation: 2,
        label: Text('$label'),
        labelStyle: TextStyle(
            color:
                chipIndex == selectedChipIndex ? Colors.black : Colors.black),
        onSelected: (v) async {
          if (selectedChipIndex != chipIndex) {
            Provider.of<AuthenticationProvider>(context, listen: false)
                .changeSelectedIndex(chipIndex);
          }
        },
        selected: chipIndex == selectedChipIndex,
      ),
    );
  }
}
