import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final TextEditingController _targetPercentageController = TextEditingController();

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
      _targetPercentageController.text = prefs.getString('targetPercentage') ?? '80.0'; // Default to 80
    });
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('batterySize', _batterySizeController.text);
    prefs.setString('percentageRemaining', _percentageRemainingController.text);
    prefs.setString('pricePerKw', _pricePerKwController.text);
    prefs.setString('chargingPower', _chargingPowerController.text);
    prefs.setString('targetPercentage', _targetPercentageController.text);
  }

  void _calculate() {
    double batterySize = double.tryParse(_batterySizeController.text) ?? 0;
    double percentageRemaining = double.tryParse(_percentageRemainingController.text) ?? 0;
    double pricePerKw = double.tryParse(_pricePerKwController.text) ?? 0;
    double chargingPower = double.tryParse(_chargingPowerController.text) ?? 0;
    double targetPercentage = double.tryParse(_targetPercentageController.text) ?? 0;

    if (batterySize > 0 &&
        percentageRemaining >= 0 &&
        percentageRemaining <= 100 &&
        pricePerKw > 0 &&
        chargingPower > 0) {
      setState(() {
        if (percentageRemaining >= targetPercentage) {
          _kwNeeded = 0;
          _time = "0 min";
          _cost = 0;
        } else {
          double kwTo80 = 0;
          double kwToTarget = 0;
          double timeTo80 = 0;
          double timeToTarget = 0;

          if (targetPercentage > 80) {
            kwTo80 = batterySize * (80 - percentageRemaining) / 100;
            kwToTarget = batterySize * (targetPercentage - 80) / 100;

            timeTo80 = kwTo80 / chargingPower;
            timeToTarget = kwToTarget / 10;

            _kwNeeded = kwTo80 + kwToTarget;
            _cost = _kwNeeded * pricePerKw;

            int totalMinutes = ((timeTo80 + timeToTarget) * 60).round();
            int hours = totalMinutes ~/ 60;
            int minutes = totalMinutes % 60;
            _time = "${hours}h${minutes.toString().padLeft(2, '0')}";
          } else {
            _kwNeeded = batterySize * (targetPercentage - percentageRemaining) / 100;
            _cost = _kwNeeded * pricePerKw;

            double timeInHours = _kwNeeded / chargingPower;
            int hours = timeInHours.floor();
            int minutes = ((timeInHours - hours) * 60).round();
            _time = "${hours}h${minutes.toString().padLeft(2, '0')}";
          }
        }
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
                    TextField(
                      controller: _batterySizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.batterySizeLabel,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _chargingPowerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.chargingPowerLabel,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _targetPercentageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.targetPercentageLabel,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _percentageRemainingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.percentageRemainingLabel,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _pricePerKwController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.pricePerKwLabel,
                        border: OutlineInputBorder(),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}