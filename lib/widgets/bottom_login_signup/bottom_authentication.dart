import 'package:flutter/material.dart';

import 'package:shop/widgets/bottom_login_signup/bls_chips_row_main.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/bottom_login_signup/login.dart';
import 'package:shop/widgets/bottom_login_signup/signup.dart';
import 'authentication_provider.dart';

class BottomAuthenticationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var index =
        context.select((AuthenticationProvider ap) => ap.getSelectedIndex);
    print('building BottomAuthenticationModal');

    return AnimatedPadding(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.white,
          height: 400,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                BLSChipsRow(chipsLabels: ['Login', 'SignUp']),
                index == 0 ? Login() : SignUp()
              ],
            ),
          ),
        ));
  }
}
