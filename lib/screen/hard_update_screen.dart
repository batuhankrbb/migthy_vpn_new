import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:mightyvpn/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extra/rate/rate_sheet_first.dart';
import '../extra/rate/rate_sheet_second.dart';

class HardUpdateScreen extends StatefulWidget {
  HardUpdateScreen({Key? key}) : super(key: key);

  @override
  State<HardUpdateScreen> createState() => _HardUpdateScreenState();
}

class _HardUpdateScreenState extends State<HardUpdateScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      globalStore.checkVersion();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: LottieBuilder.asset(
                "assets/images/update.json",
                width: context.getWidth(1),
                height: context.getHeight(0.4),
              ),
              width: context.getWidth(1),
              height: context.getHeight(0.4),
            ),
            SizedBox(
              height: context.getHeight(0.02),
            ),
            Observer(builder: (_) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.getWidth(0.03)),
                child: CustomText(
                  globalStore.versionToUpdate!.title,
                  fontWeight: fontBold,
                  maxLines: 1,
                  fontSize: context.getWidth(0.08),
                ),
              );
            }),
            SizedBox(
              height: context.getHeight(0.015),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.getWidth(0.08)),
              child: CustomText(
                globalStore.versionToUpdate!.subTitle,
                fontWeight: fontRegular,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontSize: context.width() * (0.04),
              ),
            ),
            SizedBox(
              height: context.getHeight(0.25),
            ),
            RoundedCustomButton(
              text: "SURE",
              onTap: () async {
                try {
                  var urlToOpen = globalStore.versionToUpdate!.link;
                  await launch(
                    urlToOpen,
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                } catch (e) {
                  globalStore.versionToUpdate = null;
                }
              },
              radius: context.getWidth(1),
              height: context.getHeight(0.06),
            )
          ],
        ),
      ),
    );
  }
}

extension EasyContext on BuildContext {
  double getHeight(double ratio) => MediaQuery.of(this).size.height * ratio;
  double getWidth(double ratio) => MediaQuery.of(this).size.width * ratio;
  bool get isIpad => this.getHeight(1) > 950;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get size => MediaQuery.of(this).size;

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
