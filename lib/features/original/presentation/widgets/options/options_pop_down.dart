import 'package:fitness_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class OptionsPopDown extends StatelessWidget {
  final List<String> options;
  final Function(String) onSelect;
  final Color color;

  const OptionsPopDown(
      {super.key, required this.onSelect, required this.options, required this.color});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: ImageIcon(AssetImage(CustomIcons.optionsIcon.path),
            color: color),
        onSelected: (val) {
          onSelect(val);
        },
        itemBuilder: (context) {
          return options
              .map((e) => PopupMenuItem<String>(
                    padding: const EdgeInsets.all(0),
                    value: e,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: ListTile(
                        title: Text(e),
                      ),
                    ),
                  ))
              .toList();
        });
  }
}
