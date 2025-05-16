import 'package:flutter/material.dart';
import 'package:gastos/models/expense.dart';

class AllExpensesPage extends StatefulWidget {
  final List<Expense> expenses;
  final Function(Expense) onAddExpense;

  const AllExpensesPage({
    super.key,
    required this.expenses,
    required this.onAddExpense,
  });

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Alimentos';
  bool _isFavorite = false;

  final List<String> _categories = [
    'Alimentos',
    'Transporte',
    'Ocio',
    'Salud',
    'Educación',
    'Otros',
  ];

  void _showAddExpenseDialog() {
    _titleController.clear();
    _amountController.clear();
    _selectedCategory = 'Alimentos';
    _isFavorite = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Gasto'),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Título'),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'El título es obligatorio'
                              : null,
                    ),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Monto'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final number = double.tryParse(value ?? '');
                        if (number == null || number <= 0) {
                          return 'Ingrese un monto válido';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: _categories
                          .map((cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)))
                          .toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          _selectedCategory = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Categoría'),
                    ),
                    CheckboxListTile(
                      title: const Text("Marcar como favorito"),
                      value: _isFavorite,
                      onChanged: (value) {
                        setStateDialog(() {
                          _isFavorite = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final expense = Expense(
                  title: _titleController.text.trim(),
                  amount: double.parse(_amountController.text),
                  category: _selectedCategory,
                  date: DateTime.now(),
                  isFavorite: _isFavorite,
                );

                widget.onAddExpense(expense);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los Gastos'),
      ),
      body: widget.expenses.isEmpty
          ? const Center(child: Text('No hay gastos aún.'))
          : ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                final expense = widget.expenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 4,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/a.png', // Aquí pones tu imagen fija
                      width: 40,
                      height: 40,
                    ),
                    title: Text(expense.title),
                    subtitle: Text(
                      '${expense.category} - \$${expense.amount.toStringAsFixed(2)}',
                    ),
                    trailing: expense.isFavorite
                        ? const Icon(Icons.star, color: Colors.amber)
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
