// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todoapp/quiz_app/constants.dart';
import 'package:todoapp/quiz_app/home_quiz_screen.dart';

class QuizResult extends StatelessWidget {
  int score;
   QuizResult({super.key,required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 44, 81),
        elevation: 40,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Text(
              'QUIZ RESULT',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '$score / 100',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeQuizScreen(),
                      ),
                    );
                  },
                  shape: const StadiumBorder(),
                  child: Text(
                    'Play again',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
