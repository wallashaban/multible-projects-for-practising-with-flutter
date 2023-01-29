import 'package:flutter/material.dart';
import 'package:todoapp/quiz_app/constants.dart';
import 'package:todoapp/quiz_app/quiz_question.dart';

class HomeQuizScreen extends StatefulWidget {
  const HomeQuizScreen({super.key});

  @override
  State<HomeQuizScreen> createState() => _HomeQuizScreenState();
}

class _HomeQuizScreenState extends State<HomeQuizScreen> {
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
              'QUIZ APP',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s start the quiz',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Name must not be empty';
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Full Name',
                          hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                        fillColor:Colors.white,
                          ),
                          style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuizQuestionScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'CONTINUE',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
