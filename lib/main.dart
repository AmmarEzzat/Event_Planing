import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/auth/forget_password/forget_password.dart';
import 'package:evently/auth/login/login_screen.dart';
import 'package:evently/auth/register/register_screen.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/ui/home_screen/tabs/home/add_event/add_event.dart';
import 'package:evently/ui/home_screen/tabs/home/add_event/pick_location_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

import 'package:evently/splash_screen.dart';
import 'package:evently/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork(); //offline
  runApp(
      MultiProvider(providers:[

        ChangeNotifierProvider(create: (context)=>AppLanguageProvider()),
        ChangeNotifierProvider(create: (context)=>AppThemeProvider()),
        ChangeNotifierProvider(create: (context)=>EventListProvider()),
        ChangeNotifierProvider(create: (context)=>UserProvider()),
        ChangeNotifierProvider(create: (context)=>LocationProvider())

      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageprovider=Provider.of<AppLanguageProvider>(context);
    var themeprovider=Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(languageprovider.appLanguage),
      initialRoute: LoginScreen.route,

      routes: {
        LoginScreen.route:(context)=>LoginScreen(),
        RegisterScreen.route:(context)=>RegisterScreen(),
        Splash.route: (context) => Splash(),
        HomeScreen.route: (context) => HomeScreen(),
        AddEvent.route: (context) => AddEvent(),
        ForgetPassword.route: (context) => ForgetPassword(),
        ProfileTab.route:(context)=>ProfileTab(),
        PickLocationScreen.route:(context){

          var provider = ModalRoute.of(context)?.settings.arguments as LocationProvider;
          return PickLocationScreen(provider: provider);
        }

      },

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:themeprovider.appTheme,
    );
  }
}
