import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/bottom_login_signup/authentication_provider.dart';

import 'bls_custom_chips.dart';

class BLSChipsRow extends StatelessWidget {
  final List<String> chipsLabels;

  BLSChipsRow({@required this.chipsLabels});
  @override
  Widget build(BuildContext context) {
    print('building BLSChipsRow');
    int seletedIndex = context.read<AuthenticationProvider>().getSelectedIndex;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: [
            ...List<Widget>.generate(
              chipsLabels.length,
              (int index) {
                return BLSCustomChips(
                  label: chipsLabels[index],
                  selectedChipIndex: seletedIndex,
                  chipIndex: index,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
