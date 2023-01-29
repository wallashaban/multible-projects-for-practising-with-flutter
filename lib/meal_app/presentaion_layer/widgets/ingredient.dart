import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  final String text;
  const Ingredient({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.yellow.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
