import 'dart:async';

import 'package:barika_web/models/fruits.dart';
import 'package:barika_web/sqfliteProvider/provider.dart';
import 'package:flutter/material.dart';
import 'package:idb_shim/idb_client.dart';
import 'package:idb_shim/idb_client_memory.dart';

//
// String fieldTitle = 'title';
// String fieldDescription = 'description';



class fruitProvider  extends mainProvider {

  final IdbFactory idbFactory;

  // Database db;

  Map<K, V> asMap<K, V>(dynamic value) {
    if (value is Map<K, V>) {
      return value;
    }
    if (value is Map) {
      try {
        return value.cast<K, V>();
      } catch (_) {}
    }
    return null;
  }

  static final String fruitStoreName = 'fruit';

  fruitProvider({@required this.idbFactory});

  // final notesStore = intMapStoreFactory.store(notesStoreName);
  // ObjectStore get fruitWritableTxn {
  //   var txn = db.transaction(fruitStoreName, idbModeReadWrite);
  //   var store = txn.objectStore(fruitStoreName);
  //   return store;
  // }

  // ObjectStore get fruitReadableTxn {
  //   var txn = db.transaction(fruitStoreName, idbModeReadOnly);
  //   var store = txn.objectStore(fruitStoreName);
  //   return store;
  // }


  Future<fruits> getFruitById(int id) async {
      var txn = db.transaction(fruitStoreName, idbModeReadOnly);
      var store = txn.objectStore(fruitStoreName);
    var map = asMap<String, dynamic>(await store?.getObject(id));
    if (map != null) {
      return fruits.fromJson(map);
    }
      await txn.completed;
    return null;
  }

  Future<List<fruits>> getAllFruits() async {
    print("db.objectStoreNames");
    print(db.objectStoreNames);
    print(db.name);
    var txn = db.transaction(fruitStoreName, idbModeReadOnly);
    var store = txn.objectStore(fruitStoreName);

    List<fruits> fruitList = [];


    List responseList = await store?.getAll();
    responseList.forEach((element) {
      print("element.runtimeType.toString()");
      print(element.runtimeType.toString());
      if (element != null) {
        fruitList.add(fruits.fromJson(asMap<String, dynamic>(element)));
      }
    });
    await txn.completed;

    return fruitList;
  }

  /// Add if id is null, update otherwise
  Future saveFruit(fruits fruit) async {
      var txn = db.transaction(fruitStoreName, idbModeReadWrite);
      var store = txn.objectStore(fruitStoreName);
    if (fruit.id != null) {
      await store.put(fruit.toMap(), fruit.id);
    } else {
      fruit.id = await store.add(fruit.toMap()) as int;
    }
      await txn.completed;
  }

  Future saveAllFruit(List fruit) async {
    fruit.forEach((element) async {
      await saveFruit(fruits.fromJson(element));
    });
  }

  Future deleteFruitById(int id) async {
    var txn = db.transaction(fruitStoreName, idbModeReadWrite);
    var store = txn.objectStore(fruitStoreName);
    if (id != null) {
      await store.delete(id);
    }
    await txn.completed;
  }

  Future deleteAllFruit(List delFruit) async {
    delFruit.forEach((element) async {
      await deleteFruitById(fruits
          .fromJson(element)
          .id);
    });
  }


// void onUpgradeNeeded(VersionChangeEvent event) {
//   var db = event.database;
//   db.createObjectStore(fruitStoreName, autoIncrement: true);
// }


}
// Future<int> getCount() async {
//   var store = fruitReadableTxn;
//   var count = await store.count();
//   return count;
// }

  // Future clearAllFruits() async {
  //   var store = fruitWritableTxn;
  //   await store.openKeyCursor(autoAdvance: true).listen((cursor) {
  //     cursor.delete();
  //   }).asFuture();
  // }
  //
  // Future close() async {
  //   db.close();
  // }


// Note cursorToNote(CursorWithValue/*<int, Map<String, dynamic>>*/ cursor) {
//   Map<K, V> asMap<K, V>(dynamic value) {
//     if (value is Map<K, V>) {
//       return value;
//     }
//     if (value is Map) {
//       try {
//         return value.cast<K, V>();
//       } catch (_) {}
//     }
//     return null;
//   }
//
//   Note note;
//   var snapshot = asMap(cursor.value);
//   if (snapshot != null) {
//     note = Note.fromMap(snapshot, cursor.primaryKey as int);
//   }
//   return note;
// }


// fruits cursorToNote(CursorWithValue/*<int, Map<String, dynamic>>*/ cursor) {
//   Map<K, V> asMap<K, V>(dynamic value) {
//     if (value is Map<K, V>) {
//       return value;
//     }
//     if (value is Map) {
//       try {
//         return value.cast<K, V>();
//       } catch (_) {}
//     }
//     return null;
//   }
//
//   fruits _fruits;
//   var snapshot = asMap(cursor.value);
//   if (snapshot != null) {
//     _fruits = fruits.fromMap(snapshot, cursor.primaryKey as int);
//   }
//   return note;
// }


// Future<List<Note>> getNotes() async {
//   // devPrint('getting $offset $limit');
//   var list = <Note>[];
//   var store = notesReadableTxn;
//   // ignore: cancel_subscriptions
//   StreamSubscription subscription;
//   subscription = store
//       .openCursor(direction: idbDirectionPrev, autoAdvance: true)
//       .listen((cursor) {
//     try {
//       var map = asMap<String, dynamic>(cursor.value);
//
//       if (map != null) {
//         var note = cursorToNote(cursor);
//         // devPrint('adding ${note}');
//         list.add(note);
//       }
//     } catch (e) {
//       // devPrint('error getting list notes $e');
//     }
//   });
//   await subscription.asFuture();
//   return list;
// }
