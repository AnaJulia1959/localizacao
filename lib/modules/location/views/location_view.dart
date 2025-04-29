import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/location_viewmodel.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  String _format(double value) {
    final graus = value.truncate();
    final minutosTotal = (value - graus).abs() * 60;
    final minutos = minutosTotal.truncate();
    final segundos = ((minutosTotal - minutos) * 60).toStringAsFixed(2);
    return "$graus° $minutos' $segundos\"";
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LocationViewModel>();
    final loc = vm.current;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Localização com location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: loc == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Minha localização atual',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_format(loc.latitude)),
                  Text(_format(loc.longitude)),
                ],
              ),
      ),
    );
  }
}
