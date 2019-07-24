import 'package:flutter/material.dart';
import 'package:budget/widgets/budget_list.dart';
import 'package:budget/widgets/transaction_list.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    BudgetList(),
    TransactionList(),
    Text(
      'Cash Flows',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeter'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Budget'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Transactions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            title: Text('Cash Flow'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}