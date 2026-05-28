enum WalletDepositMethod {
  card(0),
  cash(1),
  instant(2);

  final int apiValue;
  const WalletDepositMethod(this.apiValue);
}
