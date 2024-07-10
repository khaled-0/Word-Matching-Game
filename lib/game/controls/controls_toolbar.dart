import 'package:flutter/material.dart';

class ControlsToolbar extends StatelessWidget {
  const ControlsToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text("Ⓒ Khaled"),
        ),
        TextButton(
          onPressed: () {},
          child: Text("Preferences"),
        )
      ],
    );
  }
}
