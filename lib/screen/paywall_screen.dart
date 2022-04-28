import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'bottom_nav_bar.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paywall"),
      ),
      body: Center(
          child: TextButton(
        child: Text("Skip PAYWALL"),
        onPressed: () {
          push(const BottomNavBar(),
              pageRouteAnimation: PageRouteAnimation.Fade);
        },
      )),
    );
  }
}
