import 'package:flutter/material.dart';
import 'main.dart';
import 'utility.dart';

var myBoxShadow = BoxShadow(
    blurRadius: 4,
    offset: const Offset(0, 3),
    color: Colors.black.withOpacity(0.5));

const LinearGradient myGradient = LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [Color(0xffff0000), Color(0xff3300c3)]);

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.grad, this.style});

  final String text;
  final TextStyle? style;
  final Gradient grad;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>
            grad.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(text, style: style));
  }
}

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
        decoration: BoxDecoration(
            gradient: myGradient,
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            boxShadow: [myBoxShadow]),
        child: TextButton(
          style: style,
          onPressed: onPressed,
          child: child,
        ));
  }
}

class MySelectableButton extends StatelessWidget {
  const MySelectableButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.selected = false,
      this.style = const ButtonStyle()});

  final Widget child;
  final void Function() onPressed;
  final bool selected;
  final ButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: selected ? myGradient : null,
            // color: const Color(0xff212121),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            boxShadow: selected ? [myBoxShadow] : null),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xff212121),
                borderRadius: BorderRadius.circular(18),
                boxShadow: selected ? null : [myBoxShadow]),
            margin: const EdgeInsets.all(5),
            child: TextButton(
              style: style,
              onPressed: onPressed,
              child: child,
            ),
          ),
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
        const SizedBox(height: 9),
        SliderTheme(
          data: SliderThemeData(
              overlayShape: SliderComponentShape.noOverlay,
              trackShape: const GradientRectSliderTrackShape(
                  gradient: myGradient, darkenInactive: false),
              trackHeight: 20,
              thumbColor: Colors.white,
              activeTrackColor: const Color(0xff212121),
              inactiveTrackColor: const Color(0xff212121)),
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
