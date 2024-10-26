import 'package:flutter/material.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    required this.onPressed,
  });
  final double? width;
  final double? height;
  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          onPressed: onPressed,
          child: Text(
            text!,
            style: AppTextStyle.getbodymTextStyle(
              context,
            ),
          )),
    );
  }
}
