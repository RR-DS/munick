import 'dart:convert';
import 'package:flutter/rendering.dart';

class Boi {
  int? id;
  String nome;
  String raca;
  int idade;

  Boi(this.id, this.nome, this.raca, this.idade);
  Boi.novo(this.nome, this.raca, this.idade);

  Map<String, dynamic> toMap() {
    return {
      'boi_id': this.id,
      'boi_nome': this.nome,
      'boi_raca': this.raca,
      'boi_idade': this.idade
    };
  }

  static Boi fromMap(Map<String, dynamic> map) {
    return Boi(
      map['boi_id'],
      map['boi_nome'],
      map['boi_raca'],
      map['boi_idade'],
    ); //id, nome, raca, idade)
  }

  static List<Boi> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Boi.fromMap(maps[i]);
    });
  }

  static Boi fromJson(String j) => Boi.fromMap(jsonDecode(j));
  static List<Boi> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Boi>((map) => Boi.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
//POR FROM MAP E TO MAP
//CRUD_BOI 
//FAZER