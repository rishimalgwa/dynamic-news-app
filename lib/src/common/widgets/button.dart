import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pingo_assignment_app/src/common/helpers/size.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.svgIconPath,
    this.icon,
  });

  final String text;
  final void Function()? onPressed;
  final Color? buttonColor, textColor;
  final String? svgIconPath;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeHelper(context).wHelper(60),
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(buttonColor ?? ThemeHelper.primaryColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgIconPath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(svgIconPath!, width: 20, height: 20),
              ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: icon,
              ),
            Text(text,
                style: ThemeHelper.buttonTextStyle
                    .copyWith(color: textColor ?? ThemeHelper.white)),
          ],
        ),
      ),
    );
  }
}
