import 'package:budget/models/buget.dart';
import 'package:budget/models/transaction.dart' as budgeter;
import 'package:budget/util/db.dart';
import 'package:budget/widgets/date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionBuilderForm extends StatefulWidget {
  TransactionBuilderForm([this.transaction]);
  final budgeter.Transaction transaction;

  @override
  _TransactionBuilderFormState createState() =>
      _TransactionBuilderFormState(transaction);
}

class _TransactionBuilderFormState extends State<TransactionBuilderForm> {
  _TransactionBuilderFormState(this._transaction);

  static const budgetListTitle = 'Select a Budget';
  final _key = GlobalKey<FormState>();
  budgeter.Transaction _transaction;
  String budgetName;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (_transaction == null) {
      _transaction = budgeter.Transaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('budgets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final budgets = snapshot.data.documents
              .map((document) =>
                  Budget.fromJson(document.data, document.documentID))
              .toList();
          final budgetNames = budgets.map((budget) => budget.name).toList();
          if (budgetName == null) {
            budgetName = budgets?.firstWhere((budget) {
              return budget?.id == _transaction?.budgetId;
            }, orElse: () => null)?.name;
          }

          return Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Form(
              key: this._key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _transaction?.name,
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Enter Transaction Name',
                      ),
                      onSaved: (String enteredText) {
                        this._transaction.name = enteredText;
                      },
                    ),
                    TextFormField(
                      initialValue: _transaction?.amount?.toStringAsFixed(0),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter the transaction amount",
                      ),
                      onSaved: (amount) {
                        this._transaction.amount = double.parse(amount);
                      },
                    ),
                    DropdownButtonFormField(
                      value: budgetName,
                      hint: Text(budgetListTitle),
                      items: budgetNames.map((name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Text(name),
                        );
                      }).toList(),
                      onSaved: (String text) {
                        budgetName = text;
                      },
                      onChanged: (String newBudgetName) => setState(() {
                            budgetName = newBudgetName;
                          }),
                    ),
                    DatePicker(
                        labelText: 'Select Transaction Date',
                        selectedDate: selectedDate,
                        onSelectDate: (DateTime date) {
                          setState(() {
                            selectedDate = date;
                          });
                        }),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: RaisedButton(
                            onPressed: () async {
                              this._key.currentState.save();
                              var selectedBudget = budgets.firstWhere(
                                  (budget) =>
                                      budget.name == budgetName);
                              _transaction.budgetId = selectedBudget.id;
                              if (_transaction.transactionId == null) {
                                Firestore.instance
                                    .collection('transactions')
                                    .document(_transaction.transactionId)
                                    .updateData(_transaction.toMap());
                              } else {
                                Db().upload(_transaction, 'transactions');
                              }
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.playlist_add_check),
                          ),
                        ))
                  ]),
            ),
          );
        });
  }
}
