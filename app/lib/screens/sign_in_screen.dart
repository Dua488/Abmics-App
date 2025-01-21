import 'package:amlportal/controllers/container_controller.dart';
import 'package:amlportal/controllers/sing_in_controller.dart';
import 'package:amlportal/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/v_data_service.dart';
import '../customs/v_sizes.dart';
import '../customs/v_validator.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final dataService = VDataService.instance;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(dataService.isEnglish.value ? 'Sign in' : 'تسجيل الدخول', style: Theme.of(context)
            .textTheme
            .titleLarge!
            .apply(color: Colors.white, fontWeightDelta: 20),),
        // leading: IconButton(
        //     onPressed: () {},
        //     icon: ClipRRect(
        //       borderRadius: BorderRadius.circular(20.0),
        //       child: Image.asset('assets/icon.png'),
        //     )
        // ),
      ),
      body: Form(
          key: controller.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(VSizes.spaceBtwSections),
            child: Column(
            children: [
              TextFormField(
                controller: controller.email,
                validator: VValidator.validateEmail,
                decoration: InputDecoration(
                  labelText: dataService.isEnglish.value ? 'Email' : 'بريد إلكتروني',
                  prefixIcon: const Icon(Icons.send, color: Colors.green,),
                ),
              ),
              const SizedBox(height: VSizes.spaceBtwItems,),
              Obx(
                    () => TextFormField(
                  controller: controller.password,
                  validator: (value) => VValidator.validateEmptyText(dataService.isEnglish.value ? 'Password' : 'كلمة المرور', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      labelText: dataService.isEnglish.value ? 'Password' : 'كلمة المرور',
                      prefixIcon: const Icon(Icons.password, color: Colors.green,),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                            !controller.hidePassword.value;
                          },
                          icon: Icon(color: Colors.green,controller.hidePassword.value ? Icons.remove_red_eye_outlined : Icons.remove_red_eye))),
                ),
              ),
              const SizedBox(height: VSizes.spaceBtwItems,),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async{
                      await controller.emailAndPasswordSignIn();
                      if(controller.dataService.user.value.display_name.isNotEmpty){
                        Navigator.of(Get.overlayContext!).pop();
                      }
                      else{

                      }
                    },
                    child: Text(dataService.isEnglish.value ? 'Sign in' : 'تسجيل الدخول', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.green),)),
              ),
              const SizedBox(height: VSizes.spaceBtwItems,),
              TextButton(onPressed: (){
                Get.to(() => const ForgotPasswordScreen());
              }, child: Text(dataService.isEnglish.value ? 'Forgot Password?' : 'هل نسيت كلمة السر؟')),
            ],
          ),)),
    );
  }
}


