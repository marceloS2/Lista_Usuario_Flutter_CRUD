import 'package:flutter/material.dart';
import 'package:flutter_cadastro/models/user.dart';
import 'package:flutter_cadastro/provider/users.dart';
import 'package:flutter_cadastro/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  // Construtor da classe UserTile que recebe um usuário como parâmetro
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    // Avatares: Verifica se o avatar do usuário está vazio
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person_rounded)) // Se vazio, exibe ícone padrão
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl)); // Se não vazio, carrega imagem via rede

    // Retorna um ListTile para exibir informações do usuário
    return ListTile(
      leading: avatar, // Avatar do usuário à esquerda
      title: Text(user.nome), // Nome do usuário como título
      subtitle: Text(user.email), // E-mail do usuário como subtítulo
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            // Botão de edição
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                // Navega para a página de edição ao pressionar o botão de edição
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM, // Utiliza a rota definida em AppRoutes para a página de edição
                  arguments: user, // Passa o usuário como argumento para a próxima página
                );
              },
            ),
            // Botão de exclusão
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                // Exibe um diálogo de confirmação antes de excluir o usuário
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Usuário'),
                    content: const Text('Tem certeza???'),
                    actions: [
                      // Botão "Não" no diálogo
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      // Botão "Sim" no diálogo
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  // Se o usuário confirmar, remove o usuário usando o Provider
                  if (confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
