import 'package:flutter/material.dart';

import 'main.dart';
import 'utility.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.style = const ButtonStyle()});

  final Widget child;
  final void Function() onPressed;
  final ButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: TextButton(
          style: style,
          onPressed: onPressed,
          child: child,
        ));
  }
}

class MySlider extends StatelessWidget {
  const MySlider(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged,
      required this.min,
      required this.max});

  final String title;
  final double value;
  final void Function(double)? onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title:",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "LilitaOne",
                fontWeight: FontWeight.w400)),
        SliderTheme(
          data: SliderThemeData(
              // overlayShape: SliderComponentShape.noOverlay,
              trackShape: GradientRectSliderTrackShape(
                  gradient: gradient, darkenInactive: false),
              trackHeight: 20,
              thumbColor: Colors.white,
              activeTrackColor: Color(0xff212121),
              inactiveTrackColor: Color(0xff212121)),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
