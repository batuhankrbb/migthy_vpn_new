import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Stack(
        children: [
          /*
          Image.asset(
            "assets/images/paywall_background.jpg",
            width: context.width(),
            height: context.height(),
            fit: BoxFit.fill,
          ),
          */
          Container(
            width: context.width(),
            height: context.height(),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height() * 0.07,
              ),
              AutoSizeText(
                "GET PREMIUM TODAY",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.width() * 0.07,
                    fontWeight: FontWeight.w500),
              ),
              Center(
                child: LottieBuilder.asset(
                  "assets/images/paywall_lottie.json",
                  height: context.height() * 0.32,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: context.height() * 0.05,
              ),
              buildFeatureRow(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFeatureRow() {
    return Row(
      children: [
        SizedBox(width: context.width() * 0.05),
        Container(
          padding: EdgeInsets.all(4),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: GradientSvgPicture(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
            svgPicture: Icon(
              Icons.rocket,
              size: context.width() * 0.1,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

//* Svg Picture doesn't have a gradient property. So, I creatd this widget.
class GradientSvgPicture extends StatelessWidget {
  const GradientSvgPicture(
      {Key? key, required this.gradient, required this.svgPicture})
      : super(key: key);

  final Gradient gradient;
  final Widget svgPicture;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      //* SvgPicture doesn't have a gradient property. So, we should add gradident with shared mask widget.
      shaderCallback: (rect) {
        return gradient.createShader(rect);
      },
      child: svgPicture,
    );
  }
}

/*
 onPressed: () {
          Navigator.pop(context);
        },

*/
