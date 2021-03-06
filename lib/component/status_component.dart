import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../main.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';

class StatusComponent extends StatelessWidget {
  const StatusComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(VPNStatus val) {
      switch (val) {
        case VPNStatus.connecting:
          return Colors.blue;

        case VPNStatus.wait:
          return Colors.blue;

        case VPNStatus.auth:
          return Colors.blue;

        case VPNStatus.getConfig:
          return Colors.blue;

        case VPNStatus.assignIp:
          return Colors.blue;

        case VPNStatus.addRoutes:
          return Colors.red;

        case VPNStatus.connected:
          Future.delayed(Duration(seconds: 1), () {
             rateSheetViewModel.showRatingSheet(context);
          });
          return Colors.green;

        case VPNStatus.disconnected:
          return Colors.red;

        case VPNStatus.reconnecting:
          return Colors.red;

        case VPNStatus.exiting:
          return Colors.red;

        case VPNStatus.resolve:
          return Colors.blue;

        case VPNStatus.tcpConnect:
          return Colors.red;

        case VPNStatus.connectRetry:
          return Colors.red;

        case VPNStatus.noNetwork:
          return Colors.red;

        case VPNStatus.authPending:
          return Colors.yellow;

        case VPNStatus.userPause:
          return Colors.red;

        default:
          return textPrimaryColorGlobal;
      }
    }

    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: vpnStore.mVpnStage.isNotEmpty
            ? BoxDecoration(
                borderRadius: radius(),
                color: context.scaffoldBackgroundColor,
              )
            : null,
        child: AutoSizeText(
          vpnStore.mVpnStage == VpnConstants.notConnected
              ? AppCommon.getTranslateValues(VpnConstants.notConnected)
              : vpnStore.mVpnStage,
          style: boldTextStyle(
              color: getStatusColor(vpnStore.vpnStatus), size: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
