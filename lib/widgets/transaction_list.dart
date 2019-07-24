import 'package:budget/models/transaction.dart' as budgeter;
import 'package:budget/pages/transaction_builder.dart';
import 'package:budget/widgets/transaction_builder_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionList extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('transactions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final transactions = snapshot.data.documents
              .map((document) => budgeter.Transaction.fromJson(document.data, document.documentID))
              .toList();
          return Stack(
            children: <Widget>[
              ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: SizedBox(
                        height: 50.0,
                        child: InkWell(
                          splashColor: Colors.deepOrange.withAlpha(50),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TransactionBuilder(transactions[index])
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    '${transactions[index].date.month}/${transactions[index].date.day}/${transactions[index].date.year}'),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('${transactions[index].name}'),
                                    Text('${transactions[index].budgetId}')
                                  ],
                                ),
                                Text('\$${transactions[index].amount}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              Align(
                alignment: Alignment(0.9, 0.9),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TransactionBuilder()
                    ));
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          );
        });
  }
}
