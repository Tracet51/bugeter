import 'package:budget/widgets/budget_builder_form.dart';
import 'package:flutter/material.dart';

class BudgetBuilder extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Builder')
      ),
      body: BudgetBuilderForm()
    );
  }
}