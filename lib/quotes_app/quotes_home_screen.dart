import 'package:flutter/material.dart';
import 'package:todoapp/quotes_app/quote_page.dart';

class QuoteHomeScreen extends StatelessWidget {
  QuoteHomeScreen({super.key});
  final List<String> categories = [
    'love',
    'inspirational',
    'life',
    'humor',
    'books',
    'reading',
    'friendship',
    'friends',
    'truth',
    'simile',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Quotes App',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: categories.map((category) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuotePge(categoryName: category),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            category.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
