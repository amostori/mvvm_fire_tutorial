import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_fire_tutorial/view_models/store_list_vm.dart';

class StoreListPage extends StatelessWidget {
  StoreListPage({Key? key}) : super(key: key);
  final StoreListViewModel _storeListViewModel = StoreListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grocery App"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  _navigateToAddStorePage(context);
                },
              ),
            )
          ],
        ),
        body: _buildBody());
  }

  void _navigateToAddStorePage(BuildContext context) {}

  Widget _buildBody() => StreamBuilder<QuerySnapshot>(
      stream: _storeListViewModel.storesAsStream,
      builder: (context, snapshot) {
        // snapshot.data to pojedyńczy QuerySnapshot z Firebase.
        // QuerySnapshot zawiera wynik zapytania
        QuerySnapshot? querySnapshot = snapshot.data;
        if (snapshot.hasData && querySnapshot!.docs.isNotEmpty) {
          return _buildList(querySnapshot);
        } else {
          return const Text('NO_STORES_FOUND');
        }
      });

  Widget _buildList(QuerySnapshot querySnapshot) {
    return const Text('ListView.builder');
  }
}
