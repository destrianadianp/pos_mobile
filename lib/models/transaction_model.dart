class TransactionModel {
  final String id;
  final String paymentMethod;
  final double totalBill;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.paymentMethod,
    required this.totalBill,
    required this.date,
  });
}
