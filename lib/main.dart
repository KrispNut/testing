import 'package:flutter/material.dart';
import 'package:testing/l10n/l10n.dart';
import 'package:testing/screens/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/services/Sharedpreference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseService.instance.deleteDatabaseFile();
  Sharedpreference sp = Sharedpreference();
  String? language = await sp.readCache(key: 'language');
  if (language == null) {
    sp.writeCache(key: 'language', value: 'en');
    print('language added as it was empty');
  }
  runApp(MyApp(language));
}

class MyApp extends StatelessWidget {
  final String? language;

  const MyApp(this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      locale: Locale(language ?? 'en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: SplashScreen(),
    );
  }
}

// jwt tokens / bearer token authorization
// model classes json to dart
// session shared preference
