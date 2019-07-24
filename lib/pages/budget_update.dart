import 'package:budget/models/buget.dart';
import 'package:budget/widgets/budget_builder_form.dart';
import 'package:flutter/material.dart';

class BudgetUpdate extends StatelessWidget {

  BudgetUpdate(this.budget);
  final Budget budget;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: BudgetBuilderForm(budget)
    );
  }
}
