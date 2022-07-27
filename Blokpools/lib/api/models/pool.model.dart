class PoolModel {
  double maxTokens = 1;
  double minTokens = 0;
  double currentTokens = 0;
  double maxBlokRewardValue = 0;
  double apy = 0;
  double tokenPrice = 0;

  PoolModel();

  PoolModel.fromJson(Map<String, dynamic> json) {
    try {
      maxTokens = json['maxTokens'] ?? 0;
      minTokens = json['minTokens'] ?? 0;
      currentTokens = json['currentTokens'] ?? 0;
      maxBlokRewardValue = json['maxBlokRewardValue'] ?? 0;
      apy = json['apy'] ?? 0;
      tokenPrice = json['tokenPrice'] ?? 0;
    } catch (e) {
      print("Pool");
      print(e.toString());
    }
  }
}
