import 'package:flutter/material.dart';

class OpenCustomDialog extends StatelessWidget {
  final Widget widget;
  final Function() onConfirm;

  const OpenCustomDialog(
      {super.key,
      required this.widget,
      required this.onConfirm,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                widget,
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Отменить'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: const Text('Подтвердить'),
          ),
        ],
      ),
    );
  }
}
