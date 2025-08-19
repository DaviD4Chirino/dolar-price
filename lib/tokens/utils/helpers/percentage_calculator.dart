double percentageChange(
    double oldValue, double newValue) {
  if (oldValue == 0) {
    throw ArgumentError(
        "Old value cannot be zero.");
  }
  return ((newValue - oldValue) / oldValue) * 100;
}
