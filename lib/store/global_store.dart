import 'package:mobx/mobx.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStoreBase with _$GlobalStore;

abstract class _GlobalStoreBase with Store {
  @observable
  var isPremium = false;

  @observable
  var hasPaywallAlertShowed = false;

  @observable
  var isLoading = false;
}
