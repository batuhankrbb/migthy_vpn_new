import 'package:flutter/material.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

//* Dots of the onboarding screen
class OnboardDotWidget extends StatelessWidget {
  const OnboardDotWidget({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: context.width() * 0.04,
      width: context.width() * 0.04,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
