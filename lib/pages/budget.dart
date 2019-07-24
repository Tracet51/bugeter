import 'package:budget/models/transaction.dart';
import 'package:budget/pages/budget_update.dart';
import 'package:budget/widgets/budget_card.dart';
import 'package:budget/models/buget.dart';
import 'package:budget/widgets/ink_well_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  final Budget budget;
  BudgetPage({@required this.budget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Detail"),
        actions: <Widget>[
          InkWellNavigator(
            child: Icon(CupertinoIcons.settings),
            newPage: BudgetUpdate(budget),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.delete),
      ),
      body: Column(
        children: <Widget>[
          BudgetCard(budget: budget),
          FutureBuilder<firebase.QuerySnapshot>(
            future: firebase.Firestore.instance
                .collection('transactions')
                .where('budgetId', isEqualTo: budget.id)
                .getDocuments(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase.QuerySnapshot> documents) {
              if (!documents.hasData) {
                return Container();
              }
              var transactions = documents.data.documents
                  .map((document) => Transaction.fromJson(document.data, document.documentID))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                '${transactions[index].date.month}/${transactions[index].date.day}/${transactions[index].date.year}'),
                            Text(transactions[index].name),
                            Text('\$${transactions[index].amount.toString()}')
                          ],
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
