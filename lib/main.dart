import 'package:flutter/material.dart';
import 'package:flutter_localizaca/modules/location/viewmodels/location_viewmodel.dart';
import 'package:flutter_localizaca/modules/location/views/location_view.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localização',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<LocationViewModel>(
        create: (BuildContext context) => LocationViewModel(),
        child: const LocationView(),
      ),
    );
  }
}
