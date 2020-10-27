import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; 
import 'Controller/Network/network_connection_check/conectivti.dart';
import 'Controller/provider/Author.dart';
import 'Controller/provider/audio_time.dart';
import 'Controller/provider/counter.dart';
import 'Controller/provider/qurandata.dart';
import 'Controller/provider/taspihTextProvider.dart';
import 'Controller/provider/text_size.dart';
import 'Screens/Doaa/doaa_home_screen.dart';
import 'Screens/home/home_screen.dart';
import 'Screens/quran/quran_screen.dart';
import 'Screens/readScreen/read_screen.dart';
import 'Screens/read_zekr/read_doaa.dart';
import 'Screens/search/search_screen.dart';
import 'Screens/taspehh/sphaa_screen.dart';
import 'Widgets/theme.dart';
import 'constans.dart';

 void main() => runApp(MyApp());
// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApp(),
//   ),
// );
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
          ConnectivityService().connectionStatusController.stream,
        ),
        ChangeNotifierProvider<Author>(create: (context) => Author()),
        ChangeNotifierProvider<AudioTimeProvid>(
            create: (context) => AudioTimeProvid()),
        ChangeNotifierProvider<TextSizeProvider>(
            create: (context) => TextSizeProvider()),
        ChangeNotifierProvider<quranDataProvider>(
            create: (context) => quranDataProvider()),
        ChangeNotifierProvider<counter>(create: (context) => counter()),
        ChangeNotifierProvider<TaspihTextProvider>(
            create: (context) => TaspihTextProvider()),
      ],
      child: MaterialApp(
         // builder: DevicePreview.appBuilder,
        theme: CustomThemeData,
        debugShowCheckedModeBanner: false,
        title: "Quran",
        initialRoute: HomeScreen.id,
        routes: {
          // SettingScreen.id: (c) => SettingScreen(),
          SearchScreen.id: (c) => SearchScreen(),
          HomeScreen.id: (c) => HomeScreen(),
          Quran_screen.id: (c) => Quran_screen(),
          ReadingScreen.id: (c) => ReadingScreen(),
          Doaaa.id: (c) => Doaaa(),
          ReadDoaa.id: (c) => ReadDoaa(),
          SphaaScreen.id: (c) => SphaaScreen(),
        },
      ),
    );
  }
}
