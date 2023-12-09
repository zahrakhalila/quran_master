import 'package:quran_master/animations/bottom_animation.dart';
import 'package:quran_master/configs/configs.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const AppButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.normalize(100),
      height: AppDimensions.normalize(20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: Color.fromARGB(255, 238, 194, 62),
        child: WidgetAnimator(
          child: Text(
            title,
            style: AppText.b1,
          ),
        ),
      ),
    );
  }
}
