import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VFunctionHelper{
  static Color? getColor(String value){
    if (value == 'Green'){
      return Colors.green;
    }
    else if (value == 'Red'){
      return Colors.red;
    }
    else if (value == 'Blue'){
      return Colors.blue;
    }
    else if (value == 'Pink'){
      return Colors.pink;
    }
    else if (value == 'Grey'){
      return Colors.grey;
    }
    else if (value == 'Purple'){
      return Colors.purple;
    }
    else if (value == 'Black'){
      return Colors.black;
    }
    else if (value == 'White'){
      return Colors.white;
    }
    else if (value == 'Yellow'){
      return Colors.yellow;
    }
    else if (value == 'Orange'){
      return Colors.orange;
    }
    else if (value == 'Brown'){
      return Colors.brown;
    }
    else if (value == 'Teal'){
      return Colors.teal;
    }
    else if (value == 'Indigo'){
      return Colors.indigo;
    }
    else{
      return null;
    }
  }

  static void showSnackBar (String message){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  static void showAlert (String title, String message){
    showDialog(
      context: (Get.context!),
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text('OK')
            )
          ],
        );
      },
    );
  }

  static void navigateToScreen (BuildContext context, Widget screen){
    Navigator.push(
        context,
        MaterialPageRoute
          (builder: (_){
          return screen;
        })
    );
  }

  static String truncatedText (String text, int maxLength){
    if (text.length <= maxLength){
      return text;
    }
    else{
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode (BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}){
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list){
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets (List<Widget> widgets, int rowSize){
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize){
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String toKhmerNumber (String strInput){
    for (final c in strInput.characters){
      strInput = strInput.replaceAll('0', '០');
      strInput = strInput.replaceAll('1', '១');
      strInput = strInput.replaceAll('2', '២');
      strInput = strInput.replaceAll('3', '៣');
      strInput = strInput.replaceAll('4', '៤');
      strInput = strInput.replaceAll('5', '៥');
      strInput = strInput.replaceAll('6', '៦');
      strInput = strInput.replaceAll('7', '៧');
      strInput = strInput.replaceAll('8', '៨');
      strInput = strInput.replaceAll('9', '៩');
    }
    return strInput;
  }
}