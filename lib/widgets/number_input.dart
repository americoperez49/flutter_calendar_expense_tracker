import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class MyNumberInput extends StatefulWidget {
  final String myLabel;
  final IconData myIcon;
  final bool enabled;
  final BehaviorSubject? $moneyButton;
  const MyNumberInput(
      {Key? key,
      required this.myLabel,
      required this.myIcon,
      required this.enabled,
      this.$moneyButton})
      : super(key: key);

  @override
  State<MyNumberInput> createState() => _MyNumberInputState();
}

class _MyNumberInputState extends State<MyNumberInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.amber[400],
            borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              icon: Icon(widget.myIcon), label: Text(widget.myLabel)),
          onFieldSubmitted: (value) => {
            if (widget.$moneyButton != null && value != "")
              {widget.$moneyButton!.add(true)}
            else if (widget.$moneyButton != null)
              {
                {widget.$moneyButton!.add(false)}
              }
          },
          enabled: widget.enabled,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey[500], borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              icon: Icon(widget.myIcon),
              label: Text(widget.myLabel),
              labelStyle: TextStyle(color: Colors.grey[400])),
          onFieldSubmitted: (value) => {print(value)},
          enabled: widget.enabled,
        ),
      );
    }
  }
}
