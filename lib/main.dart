import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Exemplo Internacionalização',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appIntl.helloWorld),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.appIntl.helloWorld),
            Text(
              context.appIntl.hello('Ramon'),
            ),
            Text(
              context.appIntl.nWombats(1),
            ),
            Text(
              context.appIntl.pronoun('male'),
            ),
            Text(
              context.appIntl.numberOfDataPoints(2),
            ),
          ],
        ),
      ),
    );
  }
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get appIntl => AppLocalizations.of(this)!;
}
