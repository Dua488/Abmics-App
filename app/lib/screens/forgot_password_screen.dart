import 'package:amlportal/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/v_data_service.dart';
import '../customs/v_sizes.dart';
import '../customs/v_validator.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    final dataService = VDataService.instance;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(dataService.isEnglish.value ? 'Forgot Password' : 'هل نسيت كلمة السر', style: Theme.of(context)
            .textTheme
            .titleLarge!
            .apply(color: Colors.white),),
        // leading: IconButton(
        //     onPressed: () {},
        //     icon: ClipRRect(
        //       borderRadius: BorderRadius.circular(20.0),
        //       child: Image.asset('assets/icon.png'),
        //     )
        // ),
      ),
      body: Form(
          key: controller.forgotPasswordFormKey,
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
                const SizedBox(height: VSizes.spaceBtwSections,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async{
                        bool success = await controller.forgotPassword();
                        if(success){
                          Future.delayed(const Duration(seconds: 1)).then((val) {
                            // Your logic here
                            Navigator.of(Get.overlayContext!).pop();
                          });

                        }
                        else{

                        }
                      },
                      child: Text(dataService.isEnglish.value ? 'Submit' : 'يُقدِّم', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.green),)),
                ),
              ],
            ),)),
    );
  }
}
