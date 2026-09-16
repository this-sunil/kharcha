class WalletModel {
  final String title;

  const WalletModel({required this.title});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(title: json['title'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
