import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/common/humidity_scaffold.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_data.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => HumidityData()), ChangeNotifierProvider(create: (_) => HumidityProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HumidityScaffold(),
      ),
    );
  }
}
