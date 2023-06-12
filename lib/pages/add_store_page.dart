import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/add_store_viewmodel.dart';

class AddStorePage extends StatelessWidget {
  AddStorePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late AddStoreViewModel addStoreViewModel;

  @override
  Widget build(BuildContext context) {
    addStoreViewModel = Provider.of<AddStoreViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Add Store")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    addStoreViewModel.storeName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store name";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter store name"),
                ),
                TextFormField(
                  onChanged: (value) => addStoreViewModel.storeAddress = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store address";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter store address"),
                ),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary, //
                    // Background color
                  ),
                  child: Text("Save",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  onPressed: () {
                    _saveStore(context);
                  },
                ),
                const Spacer(),
                Text(addStoreViewModel.message)
              ],
            ),
          ),
        ));
  }

  void _saveStore(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final isSaved = await addStoreViewModel.saveStore();
      if (isSaved) {
        Navigator.pop(context);
      }
    }
  }
}
