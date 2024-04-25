import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class ListBar extends StatelessWidget {
  final Function() onAdd;
  final int planAmount;
  const ListBar({super.key, required this.planAmount, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Мои тренеровочные планы: ${planAmount.toString()}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, height: 1),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.green73D13D.color,
            ),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(28),
              child: const Icon(
                Icons.add,
                color: Colors.black, // Set icon color
              ),
            ),
          )
        ],
      ),
    );
  }
}
