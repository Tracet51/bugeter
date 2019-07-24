import 'package:budget/models/budgeter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Db {

  static final Db _db = Db._internal();

  factory Db() {
    return _db;
  }

  Db._internal();
  
  Future upload(BudgeterModel model, String collectionName) async {
    await Firestore.instance
      .collection(collectionName)
      .add(model.toMap());
  }
}