import 'package:amlportal/controllers/container_controller.dart';
import 'package:amlportal/controllers/sign_up_controller.dart';
import 'package:amlportal/controllers/sing_in_controller.dart';
import 'package:amlportal/customs/v_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/v_sizes.dart';
import '../customs/v_validator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final dataService = VDataService.instance;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(dataService.isEnglish.value ? 'Sign up' : 'اشتراك', style: Theme.of(context)
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
      body: SingleChildScrollView(
        child: Form(
            key: controller.loginFormKey,
            child: Padding(
              padding: const EdgeInsets.all(VSizes.spaceBtwSections),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => VValidator.validateEmptyText(dataService.isEnglish.value ? 'First name' : 'الاسم الأول', value),
                    decoration: InputDecoration(
                      labelText: dataService.isEnglish.value ? 'First name' : 'الاسم الأول',
                      prefixIcon: const Icon(Icons.short_text, color: Colors.green,),
                    ),
                  ),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => VValidator.validateEmptyText(dataService.isEnglish.value ? 'Last name' : 'اسم العائلة', value),
                    decoration: InputDecoration(
                      labelText: dataService.isEnglish.value ? 'Last name' : 'اسم العائلة',
                      prefixIcon: const Icon(Icons.person_2_outlined, color: Colors.green,),
                    ),
                  ),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  TextFormField(
                    controller: controller.email,
                    validator: VValidator.validateEmail,
                    decoration: InputDecoration(
                      labelText: dataService.isEnglish.value ? 'Email' : 'بريد إلكتروني',
                      prefixIcon: const Icon(Icons.mail_outline, color: Colors.green,),
                    ),
                  ),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => VValidator.validatePhoneNumber(value),
                    decoration: InputDecoration(
                      labelText: dataService.isEnglish.value ? 'Phone number' : 'رقم التليفون',
                      prefixIcon: const Icon(Icons.phone_android, color: Colors.green,),
                    ),
                  ),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  TextFormField(
                    controller: controller.password,
                    validator: (value) => VValidator.validateEmptyText(dataService.isEnglish.value ? 'Password' : 'كلمة المرور', value),
                    decoration: InputDecoration(
                        labelText: dataService.isEnglish.value ? 'Password' : 'كلمة المرور',
                        prefixIcon: const Icon(Icons.password, color: Colors.green,),
                    ),
                  ),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                          await controller.signUpUser();
                          if(controller.dataService.user.value.display_name.isNotEmpty){
                            Navigator.of(Get.overlayContext!).pop();
                          }
                          else{

                          }
                        },
                        child: Text(dataService.isEnglish.value ? 'Sign up' : 'اشتراك', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.green),)),
                  )
                ],
              ),)),
      ),
    );
  }
}


