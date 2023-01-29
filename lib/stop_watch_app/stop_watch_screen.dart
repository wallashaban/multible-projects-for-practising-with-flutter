import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  var swatch = Stopwatch();
  int seconds = 0, minutes = 0, hours = 0;
  String sec = '00', min = '00', hour = '00';
  Timer? timer;
  bool isStart = false;
  List lab = [];
  void start() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          isStart = true;
          seconds++;
          if (seconds == 59) {
            minutes++;
            seconds = 0;
          }
          if (minutes == 59 && seconds == 59) {
            minutes = 0;
            hours++;
          }
          sec = seconds <= 9 ? '0${seconds.toString()}' : seconds.toString();
          min = minutes <= 9 ? '0${minutes.toString()}' : minutes.toString();
          hour = hours <= 9 ? '0${hours.toString()}' : hours.toString();
        });
      },
    );
  }

  void pause() {
    isStart = false;
    setState(() {
      timer!.cancel();
    });
  }

  void reset() {
    setState(() {
      timer!.cancel();
      sec = '00';
      min = '00';
      hour = '00';
      seconds = 0;
      minutes = 0;
      hours = 0;
      isStart = false;
    });
  }

  String? labs;
  void addLab() {
    labs = '$hour:$min:$sec';
    lab.add(labs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1C2757),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Stop Watch App',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  '$hour:$min:$sec',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(vertical: 50.0),
                    width: double.infinity,
                    //height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      itemCount: lab.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lap n*${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              lab[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          !isStart ? start() : pause();
                        },
                        /* padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 5.0), */
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        child: Text(
                          isStart ? 'Pause' : 'Start',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                        ),
                      ),
                    ),
                    IconButton(
                        //padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        onPressed: () {
                          addLab();
                        },
                        icon: const Icon(
                          Icons.flag,
                          color: Colors.white,
                          size: 45,
                        )),
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          reset();
                        },
                        shape: const StadiumBorder(),
                        fillColor: Colors.blue,
                        /* padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 5.0), */
                        child: Text(
                          'Reset',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
