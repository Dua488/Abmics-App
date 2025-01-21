import 'package:amlportal/LocalString.dart';
import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'customs/v_general_binding.dart';
import 'customs/v_app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;
    return GetMaterialApp(
      translations: Localstring(),
      locale: dataService.currentLocal,
      initialBinding: VGeneralBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: VAppTheme.lightTheme,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(99, 167, 88, 1.0),
        body: Stack(
          children: [
            Center (
              child: Image(image: AssetImage('assets/bg.png')),
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
      getPages: AppRoutes.pages,
    );
  }
}
//119/171/100