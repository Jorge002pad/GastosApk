class Expense {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final bool isFavorite;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.isFavorite = false,
  });
}
