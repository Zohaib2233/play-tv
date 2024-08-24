import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:play_tv/helper/custom_delegate.dart';
import 'package:play_tv/localization/app_localization.dart';
import 'package:play_tv/provider/auth_provider.dart';
import 'package:play_tv/provider/channel_provider.dart';
import 'package:play_tv/provider/localization_provider.dart';
import 'package:play_tv/provider/splash_provider.dart';
import 'package:play_tv/provider/theme_provider.dart';
import 'package:play_tv/theme/dark_theme.dart';
import 'package:play_tv/theme/light_theme.dart';
import 'package:play_tv/util/app_constant.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/view/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChannelProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorResources.getDeepForestBrown(context)
          //color set to purple or set your own color
        ));

    List<Locale> _local = [];
    AppConstants.languages.forEach((language) {
      _local.add(Locale(language.languageCode ?? "en", language.countryCode));
    });

    return MaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: _local,
    home: SplashScreen(),
     // home: VideoPlayerScreen(videoUrl: "https://youtu.be/LrVHR48Dehs"),
    );
  }
}
