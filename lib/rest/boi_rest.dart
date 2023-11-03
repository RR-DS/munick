import 'dart:html';
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
//BOI_REST.DART (3)
  Future<List<Boi>> buscarTodos() async {
    final http.Response response = 
      await http.get (Uri.http(API.endpoint, "bois"));
    if (response.statusCode == 200) {
      return Boi.fromJsonList(response.body);
       } else {
        throw Exception('Erro buscando todos os bois');
       }

  }
  //BOI_REST.DART (4)
  Future<Boi> inserir(Boi boi) async {
    final http.Response response = await http.post (
      Uri.http(API.endpoint, 'bois'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: boi.toJson()
    );
  }

//BOI_REST.DART (5)
  Future<Boi> alterar(Boi boi) async {
        final http.Response response = await http.put(
          Uri.http(API.endpoint, 'bois/${boi.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: boi.toJson(), 
        );
        if (response.statusCode == 200) {
          return boi;
        } else {
          throw Exception ('Erro alternando boi ${boi.id}.');
        }}
      
  
//BOI_REST.DART (6)  
  Future<Boi> remover(int id) async {
      final http.Response response = 
      await http.delete (
        Uri.http (API.endpoint, '/bois/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8' ,
        }
      );
      if (response.statusCode == 200) {
        return Boi.fromJson(response.body);
        } else {
          throw Exception('Erro removido boi: $id.');
        }





  }
}
