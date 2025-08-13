class CurrencyRates {
  CurrencyRates(
    this.usd,
    this.eur,
    this.cny,
    // this.try_,
    this.rub,
  );

  double usd;
  double eur;
  double cny;
  // double try_;
  double rub;

  Map<String, double> get currencies => {
        "USD": usd,
        "EUR": eur,
        "CNY": cny,
        "RUB": rub,
      };
}
