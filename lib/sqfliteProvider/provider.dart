import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idb_shim/idb_client.dart';
import 'package:idb_shim/idb_client_memory.dart';


const String dbName = 'note.db';

const int kVersion1 = 1;

class MemoryMainProvider extends mainProvider {
  MemoryMainProvider() : super(idbFactory: idbFactoryMemory);


}

class mainProvider {
  final IdbFactory idbFactory;
  Database db;

  mainProvider({@required this.idbFactory});


  Future open() async {

    db = await idbFactory.open(dbName,
        version: kVersion1, onUpgradeNeeded: onUpgradeNeeded);
  }

  void onUpgradeNeeded(VersionChangeEvent event) {
    var db = event.database;
    db.createObjectStore("notes");
    db.createObjectStore("fruit");
    db.createObjectStore("cereals");


  }

  Future close() async {
    db.close();
  }
}

