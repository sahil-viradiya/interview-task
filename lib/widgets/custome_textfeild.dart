import 'package:flutter/material.dart';
import 'package:movie_app/constant/color_constant.dart';

class CustomFilledTextFormFieldWidget extends StatelessWidget {
  const CustomFilledTextFormFieldWidget(
      {super.key,
      this.validator,
      this.controller,
      this.onSaved,
      this.hintText,
      this.onchanged,
      this.minLine,
      this.icon,
      this.enable,
      this.maxLine,
      this.readOnly,
      this.suffixTap,
        this.keyboardType,
      this.isCapital});
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final TextCapitalization? isCapital;
  final bool? readOnly;
  final void Function(String?)? onchanged;
  final bool? enable;
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? icon;
  final GestureTapCallback? suffixTap;

  final int? minLine;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: keyboardType,
          style: const TextStyle(height: 1),
          textCapitalization: isCapital == null
              ? TextCapitalization.none
              : TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onSaved: onSaved,
          enabled: enable,
          controller: controller,
          readOnly: readOnly ?? false,
          validator: validator,
          minLines: minLine ?? 1,
          maxLines: maxLine ?? 1,
          onChanged: onchanged,
          decoration: InputDecoration(
            fillColor: Colors.white,

            filled: true,
            isDense: true,
            // isCollapsed: true,
            suffixIcon: GestureDetector(onTap: suffixTap, child: Icon(icon)),
            suffixStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:  BorderSide(
                color: ColorConstant.primaryColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:  BorderSide(
                color: ColorConstant.primaryColor,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:  BorderSide(
                color: ColorConstant.primaryColor,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 17.76,
            ),

            hintText: hintText,
           
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

