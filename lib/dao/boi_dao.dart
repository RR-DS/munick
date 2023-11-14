import 'package:munick/model/boi.dart';
import '../helper/error.dart';

// BOIDAO     PG 250
class BoiDAO {
  Database database;
  BoiDAO(this.database);

  //INSERIR   PG 250
  Future<void> inserir(Boi boi) async {
    await database.insert(
      "tb_boi",
      boi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //OBTERTODOS_PG251
  Future<List<Boi>> obterTodos() async {
    final List<Map<String, dynamic>> maps = await database.query("tb_boi");
    return Boi.fromMaps(maps);
  }

  //OBTERPORID_PG251
  Future<Boi?> obterPorId(int id) async {
    final List<Map<String, dynamic>> maps =
        await database.query("tb_boi", where: "boi_id = ?", whereArgs: [id]);
    if (maps.length > 0) {
      return Boi.fromMap(maps.first);
    }
    return null;
  }

  //ATUALIZAR_PG252
  Future<void> atualizar(Boi boi) async {
    await database.update(
      'tb_boi',
      boi.toMap(),
      where: "boi_id = ?",
      whereArgs: [boi.id],
    );
  }

//REMOVER._PG252
  Future<void> remover(int id) async {
    await database.delete(
      'tb_boi',
      where: "boi_id = ?",
      whereArgs: [id],
    );
  }
}












/*
250	boi_dao.dart
250	boi_dao.dart |inserir		
251	boi_dao.dart |obterTodos		
251	boi_dao.dart |obterPorId		
252	boi_dao.dart | atualizar		
252	boi_dao.dart | remover.		
*/