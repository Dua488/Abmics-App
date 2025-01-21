import 'package:amlportal/customs/v_data_service.dart';
import 'package:get/get.dart';

class VValidator {

  static VDataService dataService = Get.put(VDataService());

  static String? validateEmptyText (String? fieldName, String? value){
    if (value == null || value.isEmpty){
      //return '$fieldNameមិនអាចខ្វះបាន';
      return '$fieldName';
    }
  }

  static String? validateEmail (String? value){
    if (value == null || value.isEmpty){
      //return 'អ៊ីមែលមិនអាចខ្វះបាន';
      //return 'INFO_AND_CONTACT_EMAIL_LABEL'.tr;
      return dataService.isEnglish.value ? 'Email not valid' : 'البريد الإلكتروني غير صالح';
    }

    final emailRegExp = RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

    //final emailRegExp = RegExp(r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$');
    //final emailRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

    if (!emailRegExp.hasMatch(value)){
      //return 'ទម្រង់អ៊ីមែលមិនត្រឹមត្រូវ';
      //return 'INFO_AND_INPUT_EMAIL_REQUIRED'.tr;
      return dataService.isEnglish.value ? 'Email not valid' : 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  static String? validatePhoneNumber (String? value) {
    if (value == null || value.isEmpty) {
      //return 'លេខទូរសព្ទមិនអាចខ្វះបាន';
      return 'INFO_AND_INPUT_PHONE_REQUIRED'.tr;
    }
    //^(?:[+0]9)?[0-9]{10}$
    //final phoneRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    final phoneRegExp = RegExp(r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$');
    //final phoneRegExp = RegExp(r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$');

    if (!phoneRegExp.hasMatch(value)){
      //return 'ទម្រង់លេខទូរសព្ទមិនត្រឹមត្រូវ';
      return 'INFO_AND_INPUT_PHONE_REQUIRED'.tr;
    }
    return null;
  }

}