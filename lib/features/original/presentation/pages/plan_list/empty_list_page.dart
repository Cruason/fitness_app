import 'package:fitness_app/core/constants/constants.dart';
import 'package:flutter/material.dart';


class EmptyListPage extends StatelessWidget {
  final Function() onAddPage;
  const EmptyListPage({super.key, required this.onAddPage});

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
            Text("Ваш список планов пустой",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(height: 1, color: Colors.black)),
            const SizedBox(height: 10,),
            Text("Давайте создадим ваш первый план!",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1, color: Colors.black)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async{
               onAddPage();
              },
              style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
                  backgroundColor: MaterialStatePropertyAll(CustomColors
                      .green73D13D.color)
                  ),
              child: const Text(
                "Создать план",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
