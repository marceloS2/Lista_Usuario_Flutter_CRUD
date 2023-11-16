
import 'package:flutter/material.dart';
import 'package:flutter_cadastro/components/user_tile.dart';
import 'package:flutter_cadastro/provider/users.dart';
import 'package:flutter_cadastro/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios '),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM
                );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, index) => UserTile(users.byIndex(index)),
      ),
    );
  }
}
