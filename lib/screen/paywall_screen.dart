import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mightyvpn/utils/constant.dart';
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
      backgroundColor: onboardBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              "assets/images/paywall_lottie.json",
              height: context.height() * 0.3,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}

/*
 onPressed: () {
          Navigator.pop(context);
        },
*/
