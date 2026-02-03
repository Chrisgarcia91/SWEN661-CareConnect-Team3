import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'features/auth/login_screen.dart';
import 'features/home/app_shell.dart';
import 'features/medications/medication_list_screen.dart';
import 'features/medications/add_medication_screen.dart';
import 'features/medications/medication_detail_screen.dart';
import 'features/medications/refill_request_flow.dart';
import 'routing/routes.dart';

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

      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      
      initialRoute: AppRoutes.login,

      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.root: (_) => const AppShell(),
        AppRoutes.medications: (_) => const MedicationListScreen(),
        AppRoutes.addMedication: (_) => const AddMedicationScreen(),
        AppRoutes.medicationDetail: (_) => const MedicationDetailScreen(), // Placeholder
        AppRoutes.refillRequest: (_) => const RefillRequestFlow(),
      }, 
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