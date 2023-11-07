import 'dart:convert';

import 'package:flutter/rendering.dart';

class Boi {
  int? id;
  String nome;
  String raca;
  int idade;

  Boi(this.id, this.nome, this.raca, this.idade);
  Boi.novo(this.nome, this.raca, this.idade);

  static Boi fromJson(String j) => Boi.fromMap(jsonDecode(j));
  static List<Boi> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Boi>((map) => Boi.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
//POR FROM MAP E TOP MAP