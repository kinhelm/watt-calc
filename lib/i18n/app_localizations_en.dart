// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WattCalc';

  @override
  String get batterySizeLabel => 'Battery size (kWh)';

  @override
  String get percentageRemainingLabel => 'Percentage remaining (%)';

  @override
  String get targetPercentageLabel => 'Target percentage (%)';

  @override
  String get pricePerKwLabel => 'Price per kWh (€)';

  @override
  String get chargingPowerLabel => 'Charging power (kW)';

  @override
  String get calculateButton => 'Calculate';

  @override
  String kwBought(Object kwNeeded) {
    return 'kW bought: $kwNeeded kWh';
  }

  @override
  String totalCost(Object cost) {
    return 'Total cost: $cost €';
  }

  @override
  String estimatedTime(Object time) {
    return 'Estimated time: $time';
  }
}
