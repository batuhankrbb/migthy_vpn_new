import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../bottom_nav_bar.dart';
import 'custom_text_button.dart';

class OnboardPageWidget extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int index;

  const OnboardPageWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.index})
      : super(key: key);

  @override
  _OnboardPageWidgetState createState() => _OnboardPageWidgetState();
}

class _OnboardPageWidgetState extends State<OnboardPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                height: 60,
              ),
              if (widget.index == 2)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await setValue("showOnboard", false);
                        push(const BottomNavBar(),
                            isNewTask: true,
                            pageRouteAnimation: PageRouteAnimation.Fade);
                        mixpanel?.track('Onboard skip button clicked');
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Center(
            child: Lottie.asset(
              widget.image,
              height: context.width() * 0.6,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 55,
          ),
          AutoSizeText(
            widget.title,
            textAlign: TextAlign.start,
            style: AppTextStyle.headline(
                overflow: TextOverflow.visible,
                size: 24,
                color: onboardTextColor),
          ),
          SizedBox(
            height: 45,
          ),
          AutoSizeText(
            widget.description,
            textAlign: TextAlign.start,
            style: AppTextStyle.paragraph(
              color: onboardTextColor,
              overflow: TextOverflow.visible,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
