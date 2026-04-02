import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Color? borderColor;
  String hintText;
  String? labelText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController?controller;
int? maxLines;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
bool obscuretext;
  String? Function(String?)? validator;
  CustomTextField({
    super.key,
    this.borderColor,
    this.hintStyle,
    this.controller,
    this.validator,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.labelStyle,
    this.style,
    this.obscuretext=false,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.blackColor,
       style: style ?? AppStyles.semi16black,
obscureText: obscuretext,
validator: validator,
maxLines:maxLines ,
      decoration: InputDecoration(

        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: labelText ,
        labelStyle: labelStyle,


        hintStyle: hintStyle ?? AppStyles.semi16grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16,),

          borderSide: BorderSide(
            color: borderColor ?? AppColors.gryColor,
            width: 20,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16,

          ),

          borderSide: BorderSide(color: AppColors.redColor, width: 2),
        ),
      ),
    );
  }
}
