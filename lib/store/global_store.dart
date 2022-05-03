import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/model/version_model.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStoreBase with _$GlobalStore;

abstract class _GlobalStoreBase with Store {
  @observable
  var isPremium = false;

  @observable
  var hasPaywallAlertShowed = false;

  @observable
  var isLoading = false;

  @observable
  VersionModel? versionToUpdate;

  @action
  Future<void> checkVersion() async {
    try {
      var appInfo =
          await fireStore.collection("app").doc(Urls.packageName).get();
      if (appInfo.data() != null) {
        var versionModel = VersionModel.fromJson(appInfo.data()!);
        if (versionModel.showNoMatterWhat) {
          versionToUpdate = versionModel;
        } else {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String version = packageInfo.version;

          var currentVersionToCompare =
              num.parse(version[0] + version[1] + version[2]);
          var lowestVersionShouldBe = num.parse(
              versionModel.lowestVersionShouldBe[0] +
                  versionModel.lowestVersionShouldBe[1] +
                  versionModel.lowestVersionShouldBe[2]);
          if (currentVersionToCompare < lowestVersionShouldBe) {
            versionToUpdate = versionModel;
          }else{
              versionToUpdate = null;
          }
        }
      }
    } catch (e) {
      versionToUpdate = null;
      print(e);
    }
  }
}

/*
  CollectionReference<ServerModel>? ref;

  ServerService() {
    ref = fireStore.collection("server").withConverter<ServerModel>(
          fromFirestore: (snapshot, options) => ServerModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Stream<List<ServerModel>> getServerList() {
    return ref!.where(serverKey.isActive, isEqualTo: true).orderBy(serverKey.createdAt, descending: true).snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }
*/
