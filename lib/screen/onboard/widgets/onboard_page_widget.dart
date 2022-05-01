import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

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
                      onTap: (){
                        //TODO
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          CupertinoIcons.xmark_octagon_fill,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Center(
            child: Image(
              image: AssetImage(widget.image),
              height: context.width() * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 55,
          ),
          Text(
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
          Text(
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
