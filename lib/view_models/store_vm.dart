import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/store_model.dart';

class StoreViewModel {
  final StoreModel store;

  StoreViewModel({required this.store});

  String get storeId => store.storeId;

  String get storeName => store.name;

  String get storeAddress => store.address;

  Future<int?> get itemsCountAsync async {
    final data = await store.documentReference?.collection('items').get();
    return data?.docs.length;
  }

  factory StoreViewModel.fromSnapshot(QueryDocumentSnapshot documentSnapshot) {
    final store = StoreModel.fromSnapshot(documentSnapshot);
    return StoreViewModel(store: store);
  }
}
