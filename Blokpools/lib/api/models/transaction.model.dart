class TransactionModel {
  String? walletAddress;
  String? transactionHash;
  double? amount;
  DateTime? date;

  TransactionModel(
      {this.walletAddress, this.transactionHash, this.amount, this.date});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    try {
      walletAddress = json['walletAddress'];
      transactionHash = json['transactionHash'];
      amount = json['amount'];
      date =
          DateTime.parse(json['date'] ?? DateTime.now().toString()).toLocal();
    } catch (e) {
      print("Transaction");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletAddress'] = walletAddress;
    data['transactionHash'] = transactionHash;
    data['amount'] = amount;
    // date no ya que la pone el servidor

    return data;
  }
}
