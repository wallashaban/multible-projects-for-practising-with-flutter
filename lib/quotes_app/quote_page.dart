// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class QuotePge extends StatefulWidget {
  final String categoryName;
  const QuotePge({
    Key? key,
    required this.categoryName,
  }) : super(key: key);
  @override
  State<QuotePge> createState() => _QuotePgeState();
}

class _QuotePgeState extends State<QuotePge> {
  final screenshotController = ScreenshotController();
  bool isThereData = false;
  @override
  void initState() {
    super.initState();
    getQuote();
  }

  List quotes = [];
  List quoteAuthor = [];
  getQuote() async {
    String url = 'https://quotes.toscrape.com/tag/${widget.categoryName}/';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final quotesclass = document.getElementsByClassName('quote');
    quotes = quotesclass
        .map((element) => element.getElementsByClassName('text')[0].innerHtml)
        .toList();
    quoteAuthor = quotesclass
        .map((element) => element.getElementsByClassName('author')[0].innerHtml)
        .toList();
    setState(() {
      isThereData = true;
    });
    print('document $quoteAuthor');
  }

  copyQuote(String quote, String author, context) {
    Clipboard.setData(ClipboardData(text: '$quote\n$author')).then((value) =>
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Quote copied')))
        /* Toast.show('Quote copied', duration: Toast.lengthShort), */
        );
  }

  shareQuote() async {
    await FlutterShare.share(
      title: 'Quotes',
      text: '${widget.categoryName}Quotes',
      linkUrl: 'https://quotes.toscrape.com/tag/${widget.categoryName}',
      // chooserTitle: 'Example Chooser Title',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '${widget.categoryName} Quotes',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  !isThereData
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.black,
                        ))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15.0,
                            );
                          },
                          itemCount: quotes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 5, left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(15),
                                /* boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                blurRadius: 10,

                              ),
                            ] */
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '${quotes[index]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '${quoteAuthor[index]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.white,
                                          /* fontWeight: FontWeight.bold,
                                        fontSize: 18, */
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          copyQuote(
                                            quotes[index],
                                            quoteAuthor[index],
                                            context,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          shareQuote();
                                        },
                                        icon: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
