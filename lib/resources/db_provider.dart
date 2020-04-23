import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:fishbowl/models/card_model.dart';
import 'starting_cards.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class DbProvider {
  Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'cards.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) async {
        await newDb.execute('''
          CREATE TABLE Cards(
              id INTEGER PRIMARY KEY,
              name TEXT,
              body TEXT,
              category TEXT,
              value INTEGER,
              cardSet TEXT,
              active INTEGER)
        ''');
        var objects = json.decode(startingCardsString);
        for (Map<String, dynamic> obj in objects) {
          newDb.insert('Cards', obj);
        }
      },
    );
  }

  void deleteDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'cards.db');
    await deleteDatabase(path);
  }

  Future<CardModel> fetchCard(int id) async {
    final maps = await db.query(
      'Cards',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return CardModel.fromDb(maps.first);
    }
    print("cards was empty");
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchActiveCardMaps() async {
    final maps = await db.query(
      'Cards',
      columns: null,
      where: 'active = ?',
      whereArgs: [1],
    );
    return maps;
  }

  Future<int> addCard(CardModel card) {
    return db.insert('Cards', card.toMap());
  }
}
