import 'package:apex_assessment/resources/colors.dart';
import 'package:apex_assessment/resources/font_sizes.dart';
import 'package:apex_assessment/resources/font_weights.dart';
import 'package:apex_assessment/resources/utils.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled ;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  void Function(String)? onChanged;
  final String? Function(String?)? validator;


  InputWidget({Key? key, required this.controller, required this.isEnabled, this.backgroundColor,
    this.border, this.prefixIcon, this.hintText,this.onChanged,this.suffixIcon,this.obscureText, this.validator, this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: 56,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(4),
          border:  border
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        enabled: isEnabled,
        obscureText: obscureText ?? false,
        style:Utils().getTextStyle(FontSizeManager.px18, FontWeightManager.w400, AppColors.createScreenTextColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(12.0),
          hintText: hintText ?? "type here",
          // errorBorder: const OutlineInputBorder()
          // hintStyle: getRegularStyle(
          //     fontSize: 14,color: ColorManager.gray400
          // )
        ),
      ),
    )
    ;
  }
}