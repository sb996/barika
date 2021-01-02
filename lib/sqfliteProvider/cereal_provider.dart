import 'dart:async';


import 'package:barika_web/models/cereals.dart';
import 'package:barika_web/sqfliteProvider/provider.dart';
import 'package:flutter/material.dart';
import 'package:idb_shim/idb.dart';




class cerealProvider  extends mainProvider{

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

  static final String cerealStoreName = 'cereals';

  cerealProvider({@required this.idbFactory});

  // final notesStore = intMapStoreFactory.store(notesStoreName);
  // ObjectStore get cerealWritableTxn {
  //   var txn = db.transaction(cerealStoreName, idbModeReadWrite);
  //   var store = txn.objectStore(cerealStoreName);
  //   return store;
  // }

  // ObjectStore get cerealReadableTxn {
  //   var txn = db.transaction(cerealStoreName, idbModeReadOnly);
  //   var store = txn.objectStore(cerealStoreName);
  //   return store;
  // }

  // Future<int> getCount() async {
  //   //   var txn = db.transaction(cerealStoreName, idbModeReadOnly);
  //   //   var store = txn.objectStore(cerealStoreName);
  //   var store = cerealReadableTxn;
  //   var count = await store.count();
  //   return count;
  // }

  Future<cereals> getcerealById(int id) async {
      var txn = db.transaction(cerealStoreName, idbModeReadOnly);
      var store = txn.objectStore(cerealStoreName);

    var map = asMap<String, dynamic>(await store?.getObject(id));
    if (map != null) {
      return cereals.fromJson(map);
    }
      await txn.completed;
    return null;
  }

  Future<List<cereals>> getAllcereals() async {

      var txn = db.transaction(cerealStoreName, idbModeReadOnly);
      var store = txn.objectStore(cerealStoreName);

    List<cereals> cerealList=[];
    print(store.toString());

    List responseList = await store?.getAll();
    responseList.forEach((element) {
      print("element.runtimeType.toString()");
      print(element.runtimeType.toString());
      if (element != null) {
        cerealList.add(cereals.fromJson(asMap<String, dynamic> (element)));
      }
    });
      await txn.completed;
    return cerealList;
  }


  /// Add if id is null, update otherwise
  Future savecereal(cereals cereal) async {
      var txn = db.transaction(cerealStoreName, idbModeReadWrite);
      var store = txn.objectStore(cerealStoreName);

    if (cereal.id != null) {
      await store.put(cereal.toMap(), cereal.id);
    } else {
      cereal.id = await store.add(cereal.toMap()) as int;
    }
      await txn.completed;
  }

  Future saveAllcereal(List cereal) async {

    cereal.forEach((element) async{
      await savecereal(cereals.fromJson(element));
    });

  }

  Future deletecerealById(int id) async {
    var txn = db.transaction(cerealStoreName, idbModeReadWrite);
    var store = txn.objectStore(cerealStoreName);
    if (id != null) {
      await store.delete(id);
    }
    await txn.completed;
  }
  Future deleteAllcereal(List delcereal) async {
    delcereal.forEach((element) async{
      await deletecerealById(cereals.fromJson(element).id);
    });

  }




}


