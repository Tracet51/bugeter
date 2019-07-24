import 'package:budget/models/budgeter_model.dart';

class Budget implements BudgeterModel {

  Budget({this.amount, this.name, this.id});

  Budget.fromJson(Map<String, dynamic> json, String id) {
    this.amount = json['amount'];
    this.name = json['name'];
    this.id = id;
  }

  double amount;
  String name;
  String id;

  Map<String, dynamic> toMap() => {
    "name" : this.name,
    "amount" : this.amount
  };
}
