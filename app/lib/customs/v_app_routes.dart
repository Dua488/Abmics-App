import 'package:amlportal/customs/v_routes.dart';
import 'package:amlportal/screens/container_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
  static final pages = [
    GetPage(name: VRoutes.home, page:()=> const ContainerScreen()),
  ];
}