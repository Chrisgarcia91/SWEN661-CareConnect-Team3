import 'package:flutter/material.dart';
import 'package:care_connect_team3/app/theme/theme.dart';

void main() {
  runApp(const CareConnectApp());
}

class CareConnectApp extends StatelessWidget {
  const CareConnectApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Care Connect',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      
      home: const ThemeTestScreen(),   
    );
  }
}
class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Headline', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(hintText: 'Input test')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text('Primary Button')),
            const SizedBox(height: 12),
            const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Card test'))),
          ],
        ),
      ),
    );
  }
}