import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_page.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: const TabsPage()
      ),
    );
  }
}