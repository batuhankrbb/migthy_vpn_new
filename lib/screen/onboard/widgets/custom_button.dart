import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'custom_text_button.dart';

//* This is the main button component. Other buttons depend on this button.
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.width,
    this.gradient,
    this.fontSize,
    this.color,
    this.height = 50,
    this.padding,
    this.elevatedButtonPadding,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final LinearGradient? gradient;
  final Color?
      color; //* Either color or gradient should be null. If they aren't null, gradient will be ignored. // if you want to have a transparent background, give Colors.transparent
  final double? fontSize;
  final double? width;
  final double height;
  final EdgeInsets? padding;
  final EdgeInsets? elevatedButtonPadding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: primaryColor,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: child,
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: elevatedButtonPadding),
      ),
    );
  }
}

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: globalStore.isLoading,
          child: child,
        ),
        Observer(builder: (context) {
          if (globalStore.isLoading)
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            );
          return SizedBox();
        }),
        Observer(builder: (context) {
          if (globalStore.isLoading)
            return Center(
              child: LoadingScreen(),
            );
          return SizedBox();
        }),
      ],
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, this.isSmallLoading = false})
      : super(key: key);

  final bool isSmallLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildLoadingWidget(context),
    );
  }

  Widget buildLoadingWidget(BuildContext context) {
    if (isSmallLoading) {
      return _widgetWithBrightness(const CupertinoActivityIndicator(), context);
    } else {
      return _widgetWithBrightness(
          CupertinoActivityIndicator(radius: context.width() * (0.035)),
          context);
    }
  }

  Widget _widgetWithBrightness(Widget widget, BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: widget,
    );
  }
}
