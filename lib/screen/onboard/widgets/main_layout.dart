import 'package:flutter/material.dart';


class MainLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? content;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final bool? safeAreaBottomActivated;
  const MainLayout({
    Key? key,
    this.appBar,
    this.content,
    this.padding,
    this.alignment,
    this.backgroundColor,
    this.safeAreaBottomActivated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar,
      body: SafeArea(
        bottom: safeAreaBottomActivated ?? true,
        child: Container(
          alignment: alignment,
          padding: padding,
          child: content ?? Container(),
        ),
      ),
    );
  }
}
