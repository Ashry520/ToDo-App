import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/home/home_screen.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/app_config_provider.dart';
import 'package:toodooapp/provider/list_provider.dart';
import 'package:toodooapp/shared/constant.dart';
import 'package:toodooapp/shared/shared_pref.dart';
import 'package:toodooapp/task_list/task_save.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();

  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  bool? theme = CacheHelper.getData(key: 'isLight');
  if (theme == null || theme == true) {
    themeapp = ThemeMode.light;
  } else {
    themeapp = ThemeMode.dark;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => ListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TaskSave.routeName: (context) => TaskSave(),
      },
      theme: MyTheme.LightTheme,
      darkTheme: MyTheme.DarkTheme,
      themeMode: provider.appTheme,
    );
  }
}
