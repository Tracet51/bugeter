import 'package:budget/models/transaction.dart' as budgeter;
import 'package:budget/widgets/transaction_builder_form.dart';
import 'package:flutter/material.dart';

class TransactionBuilder extends StatelessWidget {

TransactionBuilder([this.transaction]);

final budgeter.Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Builder')
      ),
      body: TransactionBuilderForm(transaction)
    );
  }
}
