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

  Map<String, double> get allRates => {
    "USD": usd,
    "EUR": eur,
    "CNY": cny,
    "RUB": rub,
  };

  double convertRate(
    String currency,
    double amount, {
    bool reverse = false,
  }) {
    if (reverse) {
      return amount / getRate(currency);
    }
    return amount * getRate(currency);
  }

  double getRate(String currency) {
    switch (currency) {
      case "USD":
        return usd;
      case "EUR":
        return eur;
      case "CNY":
        return cny;
      case "RUB":
        return rub;
      default:
        throw Exception("Currency not found");
    }
  }

  CurrencyRates.fromJson(Map<String, dynamic> json)
    : usd = json["USD"] ?? 0,
      eur = json["EUR"] ?? 0,
      cny = json["CNY"] ?? 0,
      rub = json["RUB"] ?? 0;

  Map<String, dynamic> toJson() {
    return allRates;
  }
}
