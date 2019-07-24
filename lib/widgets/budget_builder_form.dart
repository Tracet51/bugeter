import 'package:budget/models/buget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BudgetBuilderForm extends StatefulWidget {
  BudgetBuilderForm([this.budget]);
  final Budget budget;

  @override
  _BudgetBuilderFormState createState() => _BudgetBuilderFormState(budget);
}

class _BudgetBuilderFormState extends State<BudgetBuilderForm> {
  _BudgetBuilderFormState(this._budget);

  final _key = GlobalKey<FormState>();
  Budget _budget;

  @override
  void initState() {
    super.initState();
    if (_budget == null) {
      _budget = Budget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Form(
        key: this._key,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _budget.name,
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Enter Budget Name',
                ),
                onSaved: (String enteredText) {
                  this._budget.name = enteredText;
                },
              ),
              TextFormField(
                initialValue: this._budget.amount?.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter the budget amount",
                ),
                onSaved: (amount) {
                  this._budget.amount = double.parse(amount);
                },
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: RaisedButton(
                      onPressed: () async {
                        this._key.currentState.save();
                        if (_budget.id != null) {
                          await Firestore.instance
                              .collection('budgets')
                              .document(_budget.id)
                              .updateData(_budget.toMap());
                        } else {
                          await Firestore.instance
                              .collection('budgets')
                              .add(_budget.toMap());
                        }
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.playlist_add_check),
                    ),
                  ))
            ]),
      ),
    );
  }
}
