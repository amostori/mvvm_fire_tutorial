import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_fire_tutorial/view_models/store_list_vm.dart';

import '../custom_widgets/item_count_widget.dart';
import '../view_models/store_vm.dart';

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

  Widget _buildList(QuerySnapshot snapshot) {
    final stores =
        snapshot.docs.map((doc) => StoreViewModel.fromSnapshot(doc)).toList();
    return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildListItem(store, (store) {
            _navigateToStoreItems(context, store);
          });
        });
  }

  Widget _buildListItem(StoreViewModel store,
          void Function(StoreViewModel) onStoreSelected) =>
      ListTile(
        title: Text(
          store.storeName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(store.storeAddress),
        trailing: FutureBuilder<int?>(
          future: store.itemsCountAsync,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ItemCountWidget(count: snapshot.data!);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        onTap: () => onStoreSelected(store),
      );

  void _navigateToStoreItems(BuildContext context, store) {}
}
