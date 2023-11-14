import 'package:flutter/material.dart';
import 'package:munick/dao/boi_dao.dart';
import 'package:munick/dao/connection_factory.dart';
import 'package:munick/main.dart';
import 'package:munick/model/boi.dart';
import 'package:munick/repositories/boi_repository.dart';
import '../helper/error.dart';

class EditarBoiPage extends StatefulWidget {
  static const String routeName = '/edit';

  @override
  _EditarBoiState createState() => _EditarBoiState();
}

class _EditarBoiState extends State<EditarBoiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  int _id = 0;
  Boi? _boi;

  @override
  void dispose() async {
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

//OBTER ANTIGO - SEM REST
  /*void _obterBoi() async {
    this._boi = Boi(this._id, "Boi ${this._id}", "Raça", 10);
    _nomeController.text = this._boi!.nome;
    _racaController.text = this._boi!.raca;
    _idadeController.text = this._boi!.idade.toString();
  }*/
  //OBTER NOVO - COM REST
  /*void _obterBoi() async {
    try {
      BoiRepository repository = BoiRepository();
      this._boi = await repository.buscar(this._id);
      _nomeController.text = this._boi!.nome;
      _racaController.text = this._boi!.raca;
      _idadeController.text = this._boi!.idade.toString();
    } catch (exception) {
      showError(context, "Erro recuperando boi", exception.toString());
      Navigator.pop(context);
    }
  }
        */

//CRUD | editar_boi_page.dart

  void _obterBoi() async {
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    this._boi = await dao.obterPorId(this._id);

    ConennectionFactory.factory.close();

    _nomeController.text = this._boi.nome;
    _nomeController.text = this._boi.raca;
    _nomeController.text = this._boi.idade.toString();

    try {
      BoiRepository repository = BoiRepository();
      this._boi = await repository.buscar(this._id);
      _nomeController.text = this._boi!.nome;
      _racaController.text = this._boi!.raca;
      _idadeController.text = this._boi!.idade.toString();
    } catch (exception) {
      showError(context, "Erro recuperando boi", exception.toString());
      Navigator.pop(context);
    }
  }

//SALVAR ANTIGO - SEM REST
  /* void _salvar() async {
    this._boi!.nome = _nomeController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi editado com sucesso.')));
  }
  */

//SALVAR NOVO - COM REST
  /*void _salvar() async {
    this._boi!.nome = _nomeController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    try {
      BoiRepository repository = BoiRepository();
      await repository.alterar(this._boi!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Boi editado com sucesso')));
    } catch (exception) {
      showError(context, "Erro editando boi", exception.toString());
    }
  }
      */

// CRUD | editar_boi_page.dart

  void _salvar() async {
    this._boi.nome = _nomeController.text;
    this._boi.raca = _racaController.text;
    this._boi.idade = int.parse(_idadeController.text);
  }
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    await dao.atualizar(this._boi!);

    ConennectionFactory.factory.close();

    ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text ('Boi editado com sucesso.')));
}


  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Nome:"),
              Expanded(
                  child: TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Raça:"),
              Expanded(
                  child: TextFormField(
                controller: _racaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Idade"),
              Expanded(
                  child: TextFormField(
                controller: _idadeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _salvar();
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Map m = ModalRoute.of(context)!.settings.arguments as Map;
    this._id = m["id"];
    _obterBoi();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Boi"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }


//falta met show erro pg523