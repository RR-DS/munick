import 'package:flutter/material.dart';
import 'package:munick/main.dart';

class InserirBoiPage extends StatefulWidget {
  static const String routeName = '/insert';

  @override
  _InserirBoiState createState() => _InserirBoiState();
}

//INSERIRBOIDART
class _InserirBoiState extends State<InserirBoiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

//SALVAR - INT COM BANCO
  void _salvar() async {
    _nomeController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi salvo com sucesso')));
  }

//BUILDFORM
  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nome'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Raça'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Idade'),
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
              ],
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _salvar();
                  }
                },
                child: Text('Salvar'),
              ),
            ])
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserir Boi"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
