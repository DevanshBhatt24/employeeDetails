import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:example/constants/text.dart';
import 'package:flutter/material.dart';

class DialogBox {
  void showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: 'Employee Added Successfully',
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  void showErrorsDialog(BuildContext context, String error) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: error,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
