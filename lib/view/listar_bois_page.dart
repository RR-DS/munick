import 'package:flutter/material.dart';
import 'package:munick/main.dart';
import 'package:munick/model/boi.dart';
import 'package:munick/view/editar_boi_page.dart';

//LISTARBOIPAGE
class ListarBoisPage extends StatefulWidget {
  static const String routeName = '/list';
  @override
  State<StatefulWidget> createState() => _ListarBoisState();
}

class _ListarBoisState extends State<ListarBoisPage> {
  List<Boi> _lista = <Boi>[];
//REFRESHLIST
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

//DISPOSE
  @override
  void dispose() {
    super.dispose();
  }

//REFRESHLIST
  void _refreshList() async {
    List<Boi> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }
//OBTERTODOS

  Future<List<Boi>> _obterTodos() async {
    //Banco de dados buscar as Informações
    return <Boi>[
      Boi(1, "nome", "raca", 10), //dar uma olhada aqui
    ];
  }

//REMOVEBOI
  void _removerBoi(int id) async {}
//SHOWITEM

  void _showItem(BuildContext context, int index) {
    Boi boi = _lista[index];
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text(boi.nome),
              content: Column(
                children: [
                  Text("Nome: ${boi.nome}"),
                  Text("Raça: ${boi.raca}"),
                  Text("Idade: ${boi.idade} anos"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        }));
  }

//EDITITEM
  void _editItem(BuildContext context, int index) {
    Boi b = _lista[index];
    Navigator.pushNamed(
      context,
      EditarBoiPage.routeName,
      arguments: <String, int>{"id": b.id!},
    );
  }

//REMOVEITEM

  void _removeItem(BuildContext context, int index) {
    Boi b = _lista[index];
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Remover Boi"),
              content: Text("Gostaria realmente de remover ${b.nome}?"),
              actions: [
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    _removerBoi(b.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

//BUILDITEM
  ListTile _buildItem(BuildContext context, int index) {
    Boi b = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(b.nome),
      subtitle: Text(b.raca),
      onTap: () {
        _showItem(context, index);
      },
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 'edit', child: Text('Editar')),
            const PopupMenuItem(value: 'delete', child: Text('Remover')),
          ];
        },
        onSelected: (String value) {
          if (value == 'edit')
            _editItem(context, index);
          else
            _removeItem(context, index);
        },
      ),
    );
  }

//BUILD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Listagem de Bois"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: _buildItem,
        ));
  }
}
