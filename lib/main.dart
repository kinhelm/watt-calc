import 'package:flutter/material.dart';
import 'package:WattCalc/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/watt_calc_screen.dart';

void main() {
  runApp(const WattCalc());
}

class WattCalc extends StatelessWidget {
  const WattCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WattCalc',
      theme: appTheme,
      home: const WattCalcScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}