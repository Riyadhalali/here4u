import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:here4u/navigator.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:here4u/ui/addpost/addpost.dart';
import 'package:here4u/ui/home/home_screen.dart';
import 'package:here4u/ui/register/register_screen.dart';
import 'package:here4u/ui/signin/signin.dart';
import 'package:here4u/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';

//-> main Loop
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostProvider())],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ar', 'ar_AR')
        ], // added support arabic RTL just for this app

        debugShowCheckedModeBanner: false,
        title: 'Here 4 U',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          NavigationBar.id: (context) => NavigationBar(),
          SignIn.id: (context) => SignIn(),
          RegisterPage.id: (context) => RegisterPage(),
          AddPost.id: (context) => AddPost(),
        },
      ),
    );
  }
}
