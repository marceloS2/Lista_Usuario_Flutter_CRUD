import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cadastro/data/dummy_user.dart';
import 'package:flutter_cadastro/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummy_Users};

  List<User> get all {
    return [..._items.values];
  } 

  int get count {
    notifyListeners();
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (_) => User(
            id: user.id,
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          nome: user.nome,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    _items.remove(user.id);
    notifyListeners();
    }
}
