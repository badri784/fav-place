import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_place/model/model.dart';

class AddNewitem extends StateNotifier<List<Model>> {
  AddNewitem() : super([]);
  void addnewitem(String title, File image) {
    final newitem = Model(title: title, image: image);
    state = [newitem, ...state];
  }

  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

// provider
final addNewItemProvider = StateNotifierProvider<AddNewitem, List<Model>>(
  (_) => AddNewitem(),
);
