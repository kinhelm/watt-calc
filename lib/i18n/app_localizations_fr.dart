// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'WattCalc';

  @override
  String get batterySizeLabel => 'Taille de la batterie (kWh)';

  @override
  String get percentageRemainingLabel => 'Pourcentage restant (%)';

  @override
  String get targetPercentageLabel => 'Pourcentage cible (%)';

  @override
  String get pricePerKwLabel => 'Prix du kWh (€)';

  @override
  String get chargingPowerLabel => 'Puissance de la borne (kW)';

  @override
  String get calculateButton => 'Calculer';

  @override
  String kwBought(Object kwNeeded) {
    return 'kW achetés: $kwNeeded kWh';
  }

  @override
  String totalCost(Object cost) {
    return 'Coût total: $cost €';
  }

  @override
  String estimatedTime(Object time) {
    return 'Temps estimé: $time';
  }
}
