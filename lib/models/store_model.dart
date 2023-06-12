import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String name;
  final String address;
  DocumentReference? documentReference;

  StoreModel(this.name, this.address, [this.documentReference]);

  String get storeId => documentReference!.id;

  Map<String, dynamic> toMap() => {'name': name, 'address': address};

  factory StoreModel.fromSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    return StoreModel(queryDocumentSnapshot['name'],
        queryDocumentSnapshot['address'], queryDocumentSnapshot.reference);
  }
}
