import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:here4u/emergency/emergency.dart';
import 'package:here4u/navigator.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:here4u/ui/addpost/addpost.dart';
import 'package:here4u/ui/adminControl_screen/adminControlHelperKita_screen.dart';
import 'package:here4u/ui/adminControl_screen/adminControlVolunteers_screen.dart';
import 'package:here4u/ui/helperkits/helperkits.dart';
import 'package:here4u/ui/home/components/volontaries.dart';
import 'package:here4u/ui/home/home_screen.dart';
import 'package:here4u/ui/provider/permission_provider.dart';
import 'package:here4u/ui/register/register_screen.dart';
import 'package:here4u/ui/signin/signin.dart';
import 'package:here4u/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';

//-> main Loop
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(
          create: (_) => PermissionsProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale('ar', 'ar_AR')], // added support arabic RTL just for this app

        debugShowCheckedModeBanner: false,
        title: 'SARC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          Navigations.id: (context) => Navigations(),
          SignIn.id: (context) => SignIn(),
          RegisterPage.id: (context) => RegisterPage(),
          AddPost.id: (context) => AddPost(),
          EmergencyPage.id: (context) => EmergencyPage(),
          HelperKits.id: (context) => HelperKits(),
          Voluntaries.id: (context) => Voluntaries(),
          AdminControlHelperKitsScreen.id: (context) => AdminControlHelperKitsScreen(),
          AdminControlVolunteersScreen.id: (context) => AdminControlVolunteersScreen(),
        },
      ),
    );
  }
}
