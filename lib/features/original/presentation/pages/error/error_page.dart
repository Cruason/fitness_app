import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/constants.dart';

class ErrorPage extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRefresh;

  const ErrorPage({super.key, required this.errorMessage, required this.onRefresh});

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
                child: ImageIcon(
                  AssetImage(CustomIcons.pageError.path),
                  color: CustomColors.error.color,
                )),
            const SizedBox(height: 10,),
            Text("Произошла ошибка",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(height: 1, color: CustomColors.error.color)),
            const SizedBox(height: 10,),
            Text(errorMessage ?? "Неизвестная ошибка",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1, color: CustomColors.error.color)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if(context.canPop()){
                  return context.pop();
                }
                Navigator.pop(context);
                onRefresh.call();
              },
              style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
                  backgroundColor: MaterialStatePropertyAll(CustomColors
                      .green73D13D.color)
                  ),
              child: const Text(
                "Обновить",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
