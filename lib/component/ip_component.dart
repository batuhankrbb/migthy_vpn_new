import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_ip_address/get_ip_address.dart';
import '../main.dart';

import '../utils/constant.dart';
import '../utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';

class IpComponent extends StatelessWidget {
  const IpComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return FutureBuilder(
          future: getIP(),
          builder: (context, snap) {
            return Column(
              children: [
                Text(language.lblYouAreConnectedTo,
                    style: secondaryTextStyle(size: 14)),
                8.height,
                Text(
                  snap.hasData
                      ? snap.data
                          .toString()
                          .splitBetween("{", "}")
                          .toUpperCase()
                      : language.lblGettingIP,
                  style: boldTextStyle(
                      color: primaryColor, size: 18, letterSpacing: 1.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ).paddingSymmetric(horizontal: 26);
          },
        ).visible(vpnStore.vpnStatus == VPNStatus.connected);
      },
    );
  }

  Future<dynamic> getIP() {
    try {
      return IpAddress(type: RequestType.json).getIpAddress();
    } catch (e) {
      print("error buraya ulaştı = $e");
      return "{ip: 59.1.206.3131}" as dynamic;
    }
  }
}
