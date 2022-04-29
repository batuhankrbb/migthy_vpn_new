import '../main.dart';
import '../model/server_model.dart';
import '../utils/constant.dart';
import '../utils/enums.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'vpnstore.g.dart';

class VpnStore = VpnStoreBase with _$VpnStore;

abstract class VpnStoreBase with Store {
  @observable
  VPNStatus vpnStatus = VPNStatus.disconnected;

  @observable
  bool isConnected = false;

  @observable
  bool mIsPrepared = false;

  @observable
  String start = "";

  @observable
  List<ServerModel> serverList = ObservableList<ServerModel>();

  @action
  void setServerList(List<ServerModel> val) {
    serverList = val;
    serverList.sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
  }

  @action
  void setStartAction(String val) {
    start = val;
  }

  @action
  void setIsPrepared(bool val, {bool initialize = false}) {
    mIsPrepared = val;
    if (initialize) setValue(SharedPrefKeys.isPrepared, val);
  }

  @action
  void removeServerList(int index) {
    serverList.removeAt(index);
  }

  @action
  void setConnectedStatus() {
    isConnected = vpnStatus == VPNStatus.connected;
    log("Connected Status : ${vpnStatus == VPNStatus.connected}");
  }

  @observable
  String mVpnStage = VpnConstants.notConnected;

  // Data
  @observable
  String mByteIn = "0,0 kB - 0,0 kB/s";

  @observable
  String mByteOut = "0,0 kB - 0,0 kB/s";

  @observable
  String mDuration = "00:00:00";

  @observable
  String mLastPacketReceive = "0";

  @action
  Future<void> setVPNStatus() async {
    String res = await vpnServicesMethods.getVPNStatus();
 
    if (res.validate() == 'CONNECTING') {
      vpnStatus = VPNStatus.connecting;
    } else if (res.validate() == 'WAIT') {
      vpnStatus = VPNStatus.wait;
         appStore.setLoading(true);
    } else if (res.validate() == 'AUTH') {
      vpnStatus = VPNStatus.auth;
         appStore.setLoading(true);
    } else if (res.validate() == 'GET_CONFIG') {
      vpnStatus = VPNStatus.getConfig;
         appStore.setLoading(true);
    } else if (res.validate() == 'ASSIGN_IP') {
      vpnStatus = VPNStatus.assignIp;
         appStore.setLoading(true);
    } else if (res.validate() == 'ADD_ROUTES') {
      vpnStatus = VPNStatus.addRoutes;
         appStore.setLoading(true);
    } else if (res.validate() == 'CONNECTED') {
      vpnStatus = VPNStatus.connected;
      appStore.setLoading(false);
    } else if (res.validate() == 'DISCONNECTED') {
      vpnStatus = VPNStatus.disconnected;
      appStore.setLoading(false);
    } else if (res.validate() == 'RECONNECTING') {
      vpnStatus = VPNStatus.reconnecting;
         appStore.setLoading(true);
    } else if (res.validate() == 'EXITING') {
      vpnStatus = VPNStatus.exiting;
         appStore.setLoading(true);
    } else if (res.validate() == 'NONETWORK') {
      vpnStatus = VPNStatus.exiting;
         appStore.setLoading(true);
    } else if (res.validate() == 'CONNECTRETRY') {
      vpnStatus = VPNStatus.connectRetry;
         appStore.setLoading(true);
    } else if (res.validate() == 'RESOLVE') {
      vpnStatus = VPNStatus.resolve;
         appStore.setLoading(true);
    } else if (res.validate() == 'TCP_CONNECT') {
      vpnStatus = VPNStatus.tcpConnect;
         appStore.setLoading(true);
    } else if (res.validate() == 'AUTH_PENDING') {
      vpnStatus = VPNStatus.authPending;
         appStore.setLoading(true);
    } else if (res.validate() == 'USERPAUSE') {
      vpnStatus = VPNStatus.userPause;
      appStore.setLoading(false);
    } else {
      vpnStatus = VPNStatus.disconnected;
    }
  }

  @action
  void setVpnStage(String aVpnStage) {
    mVpnStage = aVpnStage;
  }

  @action
  void setByteIn(String val) {
    if (val.trim().isEmpty) {
      mByteIn = '0,0 kB - 0,0 kB/s';
    } else {
      mByteIn = val.splitAfter('↓');
    }
  }

  @action
  void setByteOut(String val) {
    if (val.trim().isEmpty) {
      mByteOut = '0,0 kB - 0,0 kB/s';
    } else {
      mByteOut = val.splitAfter('↑');
    }
  }

  @action
  void setDuration(String aDuration) {
    mDuration = aDuration;
    log("mDuration $aDuration");
  }

  @action
  void setLastPacketReceive(String aLastPacketReceive) {
    mLastPacketReceive = aLastPacketReceive;
    log("mLastPacketReceive $aLastPacketReceive");
  }
}
