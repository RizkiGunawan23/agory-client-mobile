import 'package:agory_client_mobile/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:agory_client_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SignUpScreen(),
    );
  }
}
