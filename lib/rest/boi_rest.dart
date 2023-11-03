import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:munick/model/boi.dart';
import 'package:munick/rest/api.dart';

class BoiRest {
  Future<Boi> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, '/bois/$id'));
    if (response.statusCode == 200){
      return Boi.fromJson(response.body)
    } else {
      throw Exception (
        'Erro buscando boi: ${id} [code: ${response.statusCode}]' );
    }
  }

  Future<List<Boi>> buscarTodos() async {
    final http.Response response = 
      await http.get (Uri.http(API.endpoint, "bois"));
    if (response.statusCode == 200) {
      return Boi.fromJsonList(response.body);
       } else {
        throw Exception('Erro buscando todos os bois');
       }

  }
  Future<Boi> inserir(Boi boi) async {}
  Future<Boi> alterar(Boi boi) async {}
  Future<Boi> remover(int id) async {}
}
