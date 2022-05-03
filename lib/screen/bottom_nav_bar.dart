import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyvpn/screen/hard_update_screen.dart';
import '../main.dart';
import '../utils/constant.dart';
import 'dashboard_screen.dart';
import 'internet_speed_screen.dart';
import 'settings_screen.dart';

import 'package:nb_utils/nb_utils.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> vpnTabs = [];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    vpnTabs.add(const DashboardScreen());
    vpnTabs.add(const InternetSpeedTestScreen());
    vpnTabs.add(const SettingsScreen());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
       if (globalStore.versionToUpdate != null) {
      return HardUpdateScreen();
    }
    return Scaffold(
      body: IndexedStack(
        children: vpnTabs,
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) {
          selectedIndex = i;
          setState(() {});
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryColor.withOpacity(0.55),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.vpn_key_outlined),
            label: '',
            tooltip: language.lblVPNConnect,
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child: const Icon(Icons.vpn_key_outlined),
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.speed_outlined),
            label: '',
            tooltip: language.lblInternetSpeed,
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child: const Icon(Icons.speed_outlined),
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: '',
            tooltip: language.lblSetting,
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child: const Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
    );
    });
  }
}
