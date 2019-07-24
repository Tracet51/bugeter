import 'package:budget/models/buget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budget/models/transaction.dart' as budgeter;

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    Key key,
    @required this.budget,
  }) : super(key: key);

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    // Get the transactions associated the the budget
    return FutureBuilder(
      future: Firestore.instance
          .collection('transactions')
          .where('budgetId', isEqualTo: budget.id)
          .getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final transactions = snapshot.data.documents
            .map((document) => budgeter.Transaction.fromJson(document.data, document.documentID))
            .toList();
        var spent = 0.0;
        transactions.forEach((transaction) {
          spent += transaction.amount;
        });
        var percentBudgetRemaining = spent / budget.amount;
        var absoluteBudgetRemaining = budget.amount - spent;
        return Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${budget.name}'),
                      Text('\$ ${absoluteBudgetRemaining.toStringAsFixed(2)} Left')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      value: percentBudgetRemaining,
                    ),
                    height: 20.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
