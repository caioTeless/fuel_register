import 'package:control_c/helpers/theme.dart';
import 'package:control_c/pages/register_result_dates.dart';
import 'package:control_c/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'pages/register_data.dart';

main() => runApp(const HomeControl());

class HomeControl extends StatelessWidget {
  const HomeControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        AppRoutes.appHome: (ctx) => appSplashScreen(),
        AppRoutes.appRegister: (ctx) => const RegisterData(),
      },
      checkerboardOffscreenLayers: false,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }

  appSplashScreen() {
    return SplashScreenView(
      navigateRoute: const RegisterResultDates(),
      duration: 3000,
      imageSize: 80,
      imageSrc: 'assets/images/icon.png',
      text: 'Fuel Register',
      textType: TextType.NormalText,
      textStyle: const TextStyle(
        fontSize: 25.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
