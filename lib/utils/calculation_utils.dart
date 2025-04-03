double calculateKwNeeded(double batterySize, double percentageRemaining, double targetPercentage) {
  if (percentageRemaining >= targetPercentage) {
    return 0;
  } else {
    return batterySize * (targetPercentage - percentageRemaining) / 100;
  }
}

double calculateCost(double kwNeeded, double pricePerKw) {
  return kwNeeded * pricePerKw;
}

String calculateTime(double kwNeeded, double chargingPower) {
  double timeInHours = kwNeeded / chargingPower;
  return timeInHours < 1 ? "${(timeInHours * 60).toInt()} min" : "${timeInHours.toStringAsFixed(2)} h";
}