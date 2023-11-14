import '../helper/error.dart';

class ConennectionFactory {
  final int _version = 1;
  final String _databaseFile = 'database.db';

  ConennectionFactory._();
  static final ConennectionFactory factory = ConennectionFactory._();
  static Database? _database;
//GET DATABASE PG 249
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseFile),
      onCreate: _createDatabase,
      onUpgrade: _createDatabase,
      version: _version,
    );
    return _database;
  }

//MÉTODOS
  _createDatabase(Database db, int version) {
    return db.execute(
      "CREATE TABLE tb_boi (boi_id INTEGER PRIMARY KEY AUTOINCREMENT," +
          "boi_nome TEXT, boi_raca TEXT, boi_idade INTEGER)",
    );
  }

  _upgradeDatabase(Database db, int oldVersion, int newVersion) {
    db.execute("DROP TABLE tb_boi");
    return _createDatabase(db, _version);
  }

  close() {
    if (_database != null) {
      _database!.close();
      _database = null;
    }
  }
}
