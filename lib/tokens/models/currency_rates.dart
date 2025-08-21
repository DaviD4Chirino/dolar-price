class CurrencyRates {
  CurrencyRates({
    this.usd = 0,
    this.usdParallel = 0,
    this.btc = 0,
    this.eur = 0,
    this.cny = 0,
    this.rub = 0,
  });

  double usd;
  double eur;
  double cny;
  // double try_;
  double rub;

  double usdParallel;
  double btc;

  Map<String, double> get allRates => {
    "USD_PARALLEL": usdParallel,
    "BTC": btc,
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
      case "USD_PARALLEL":
        return usdParallel;
      case "BTC":
        return btc;
      default:
        throw Exception("Currency not found");
    }
  }

  CurrencyRates.fromJson(Map<String, dynamic> json)
    : usd = json["USD"] ?? 0,
      eur = json["EUR"] ?? 0,
      cny = json["CNY"] ?? 0,
      rub = json["RUB"] ?? 0,
      usdParallel = json["USD_PARALLEL"] ?? 0,
      btc = json["BTC"] ?? 0;

  Map<String, dynamic> toJson() {
    return allRates;
  }
}
