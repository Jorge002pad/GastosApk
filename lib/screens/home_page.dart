import 'package:flutter/material.dart';
import 'package:gastos/models/expense.dart';
import 'package:gastos/screens/all_expenses.dart';
import 'package:gastos/screens/favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _expenses = [];

  int _selectedIndex = 0;

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AllExpensesPage(expenses: _expenses, onAddExpense: _addExpense),
      Favoritos(expenses: _expenses),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Gastos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
