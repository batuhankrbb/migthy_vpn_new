import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../model/server_model.dart';

class ServerService {
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
}
