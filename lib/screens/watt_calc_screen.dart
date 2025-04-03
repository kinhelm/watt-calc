import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:WattCalc/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:WattCalc/widgets/custom_text_field.dart';
import 'package:WattCalc/utils/calculation_utils.dart';
import 'package:WattCalc/services/shared_preferences_service.dart';

class WattCalcScreen extends StatefulWidget {
  const WattCalcScreen({super.key});

  @override
  _WattCalcScreenState createState() => _WattCalcScreenState();
}

class _WattCalcScreenState extends State<WattCalcScreen> {
  final TextEditingController _batterySizeController = TextEditingController();
  final TextEditingController _percentageRemainingController = TextEditingController();
  final TextEditingController _pricePerKwController = TextEditingController();
  final TextEditingController _chargingPowerController = TextEditingController();

  double _kwNeeded = 0;
  double _cost = 0;
  String _time = "0 min";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _batterySizeController.text = prefs.getString('batterySize') ?? '';
      _percentageRemainingController.text = prefs.getString('percentageRemaining') ?? '';
      _pricePerKwController.text = prefs.getString('pricePerKw') ?? '';
      _chargingPowerController.text = prefs.getString('chargingPower') ?? '';
    });
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('batterySize', _batterySizeController.text);
    prefs.setString('percentageRemaining', _percentageRemainingController.text);
    prefs.setString('pricePerKw', _pricePerKwController.text);
    prefs.setString('chargingPower', _chargingPowerController.text);
  }

  void _calculate() {
    double batterySize = double.tryParse(_batterySizeController.text) ?? 0;
    double percentageRemaining = double.tryParse(_percentageRemainingController.text) ?? 0;
    double pricePerKw = double.tryParse(_pricePerKwController.text) ?? 0;
    double chargingPower = double.tryParse(_chargingPowerController.text) ?? 0;

    if (batterySize > 0 && percentageRemaining >= 0 && percentageRemaining <= 100 && pricePerKw > 0 && chargingPower > 0) {
      setState(() {
        double targetPercentage = 80;
        if (percentageRemaining >= targetPercentage) {
          _kwNeeded = 0;
        } else {
          _kwNeeded = batterySize * (targetPercentage - percentageRemaining) / 100;
        }
        _cost = _kwNeeded * pricePerKw;
        double timeInHours = _kwNeeded / chargingPower;
        _time = timeInHours < 1 ? "${(timeInHours * 60).toInt()} min" : "${timeInHours.toStringAsFixed(2)} h";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _batterySizeController,
                      labelText: AppLocalizations.of(context)!.batterySizeLabel,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: _chargingPowerController,
                      labelText: AppLocalizations.of(context)!.chargingPowerLabel,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: _percentageRemainingController,
                      labelText: AppLocalizations.of(context)!.percentageRemainingLabel,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: _pricePerKwController,
                      labelText: AppLocalizations.of(context)!.pricePerKwLabel,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _calculate();
                _saveData();
              },
              child: Text(AppLocalizations.of(context)!.calculateButton),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.estimatedTime(_time)),
                Text(AppLocalizations.of(context)!.kwBought(_kwNeeded)),
                Text(AppLocalizations.of(context)!.totalCost(_cost)),
              ],
            )
          ],
        ),
      ),
    );
  }
}