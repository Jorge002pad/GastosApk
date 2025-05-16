import 'package:flutter/material.dart';
import 'package:gastos/models/expense.dart';

class Favoritos extends StatelessWidget {
  final List<Expense> expenses;

  const Favoritos({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final favoriteExpenses = expenses.where((e) => e.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Favoritos'),
      ),
      body: favoriteExpenses.isEmpty
          ? const Center(child: Text('No hay gastos favoritos.'))
          : ListView.builder(
              itemCount: favoriteExpenses.length,
              itemBuilder: (context, index) {
                final expense = favoriteExpenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 4,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/a.png', // La misma imagen
                      width: 40,
                      height: 40,
                    ),
                    title: Text(expense.title),
                    subtitle: Text(
                      '${expense.category} - \$${expense.amount.toStringAsFixed(2)}',
                    ),
                    trailing: const Icon(Icons.star, color: Colors.amber),
                  ),
                );
              },
            ),
    );
  }
}
