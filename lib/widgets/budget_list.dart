import 'package:budget/models/buget.dart';
import 'package:budget/pages/budget.dart';
import 'package:budget/pages/budget_builder.dart';
import 'package:budget/widgets/ink_well_navigator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'budget_card.dart';

class BudgetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('budgets').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          default:
            final budgets = snapshot.data.documents
                .map((document) =>
                    Budget.fromJson(document.data, document.documentID))
                .toList();
            return Stack(alignment: Alignment.center, children: <Widget>[
              ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: budgets.length,
                itemBuilder: (BuildContext context, int index) {
                  var budget = budgets[index];
                  return InkWellNavigator(
                    child: new BudgetCard(budget: budget),
                    newPage: BudgetPage(budget: budget,),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Colors.transparent),
              ),
              Align(
                alignment: Alignment(0.9, 0.9),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BudgetBuilder()));
                  },
                  child: Icon(Icons.add),
                ),
              )
            ]);
            break;
        }
      },
    );
  }
}
