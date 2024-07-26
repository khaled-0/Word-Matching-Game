import 'package:flutter/material.dart';

class BoardSizePicker extends StatelessWidget {
  static List<int> choices = [6, 8, 10, 12, 14, 16, 18];

  const BoardSizePicker({
    super.key,
    required this.selection,
    required this.onSelected,
  });

  final int selection;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('Board Size', style: Theme.of(context).textTheme.titleMedium),
      const Spacer(),
      Expanded(
        flex: 8,
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          alignment: WrapAlignment.center,
          children: choices.map((e) {
            return ChoiceChip(
              label: Text(e.toString()),
              selected: selection == e,
              onSelected: (_) => onSelected(e),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
