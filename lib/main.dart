import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_direct/Provider/send_wp_provider.dart';
import 'package:whatsapp_direct/VIew/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WhatsAppProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
