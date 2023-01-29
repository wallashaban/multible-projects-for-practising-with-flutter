import 'package:flutter/material.dart';
import 'package:todoapp/quiz_app/constants.dart';
import 'package:todoapp/quiz_app/model/questions_model.dart';
import 'package:todoapp/quiz_app/quiz_res.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  var pageController = PageController(initialPage: 0);
  bool isPressed = false;
  Color trueAns = Colors.green;
  Color wrongAns = Colors.red;
  Color btnColor = secondColor;
  int score = 0;
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
              'QUIZ QUESTIONS',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              isPressed = false;
              btnColor = secondColor;
            });
          },
          itemCount: ques1.length,
          itemBuilder: (context, index) => Column(
            children: [
              Text(
                'Question ${index + 1} / ${ques1.length}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Divider(
                color: Colors.white,
                height: 10,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ques1[index].question,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < 4; i++)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: //btnColor,
                          isPressed
                              ? ques1[index].answers.entries.toList()[i].value
                                  ? trueAns
                                  : wrongAns
                              : secondColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        isPressed = true;
                        if (ques1[index].answers.entries.toList()[i].value) {
                          btnColor = trueAns;
                          score += 10;
                        } else {
                          btnColor = wrongAns;
                        }
                      });
                    },
                    shape: const StadiumBorder(),
                    child: Text(
                      ques1[index].answers.keys.toList()[i],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.orange)),
                    onPressed: () {
                      if (index + 1 != ques1.length) {
                        pageController.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.linear,
                        );
                        setState(() {
                          isPressed = false;
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizResult(score: score),
                          ),
                        );
                      }
                    },
                    child: Text(
                      index + 1 == ques1.length
                          ? 'See Result'
                          : 'Next Question',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
