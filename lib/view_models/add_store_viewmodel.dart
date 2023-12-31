import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/store_model.dart';

class AddStoreViewModel extends ChangeNotifier {
  String storeName = '';
  String storeAddress = '';
  String message = '';

  Future<bool> saveStore() async {
    bool isSaved = false;
    final store = StoreModel(storeName, storeAddress);
    try {
      await FirebaseFirestore.instance.collection('stores').add(store.toMap());
      isSaved = true;
    } on Exception catch (_) {
      message = 'Unable to save the store.';
    } catch (error) {
      message = 'Error';
    }
    notifyListeners();
    return isSaved;
  }
}
