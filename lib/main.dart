import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rechavedetorneio/views/chave_de_torneio_view.dart';
import 'package:rechavedetorneio/views/main_view.dart';
import 'package:rechavedetorneio/views/widgets/dimensoes_e_etc.dart' as info;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chave de Torneio',
      debugShowCheckedModeBanner: false,
      theme: info.myThemeData,
      home: MainView(),
      routes: {
        MainView.routeName: (context) => MainView(),
        ChaveDeTorneioView.routeName: (context) => ChaveDeTorneioView(),
      },
    );
  }
}
