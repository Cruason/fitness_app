import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class NoDetailsSelectedPage extends StatelessWidget {
  final Function() goToPlanList;
  const NoDetailsSelectedPage({super.key, required this.goToPlanList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: ImageIcon(AssetImage(CustomIcons.emptyBox.path))),
            const SizedBox(height: 10,),
            Text("План не выбран",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(height: 1, color: Colors.black)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                goToPlanList();
              },
              style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
                  backgroundColor: MaterialStatePropertyAll(CustomColors
                      .green73D13D.color)
              ),
              child: const Text(
                "Выбрать план",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
