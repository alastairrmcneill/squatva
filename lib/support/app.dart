// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/support/theme.dart';
import 'package:squatva/support/wrapper.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Squatva',
      theme: settingsNotifier.darkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      home: const Wrapper(),
    );
  }
}
