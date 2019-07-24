import 'package:budget/models/budgeter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction implements BudgeterModel {

  Transaction({this.name, this.amount, this.date, this.budgetId});
  Transaction.fromJson(Map<String, dynamic> json, String transactionId) {
    this.name = json['name'];
    this.amount = json['amount'];
    this.budgetId = json['budgetId'];

    Timestamp timestamp = json['date'];
    this.date = timestamp.toDate();
    this.transactionId = transactionId;
  }

  String transactionId;
  String name;
  double amount;
  DateTime date;
  String budgetId;

  Map<String, dynamic> toMap() => {
    'name' : this.name,
    'amount' : this.amount,
    'date' : this.date,
    'budgetId' : this.budgetId
  };
}
