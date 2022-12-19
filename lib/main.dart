import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(Vibrator());
}

class Vibrator extends StatelessWidget {
  const Vibrator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Body(),
        ));
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _seconds = 10;

  @override
  Widget build(BuildContext context) {
    var pattern = Patterns[0];
    return Container(
      width: double.infinity,
      height: double.infinity,
      // Below is the code for Linear Gradient.
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(239, 20, 20, 20), Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    Color.fromARGB(255, 110, 110, 110),
                    Color.fromARGB(255, 73, 73, 73),
                  ]).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    "Vibranium",
                    style: TextStyle(
                        fontFamily: "BlackCherry",
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => pattern = Patterns[0],
                        icon: Icon(
                          Icons.one_k,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () => pattern = Patterns[1],
                        icon: Icon(
                          Icons.two_k,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () => pattern = Patterns[2],
                        icon: Icon(
                          Icons.three_k,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () => pattern = Patterns[3],
                        icon: Icon(
                          Icons.four_k,
                          color: Colors.white,
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 1,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                      thumbColor: Color.fromARGB(255, 92, 92, 92),
                      overlayColor: Color.fromARGB(32, 92, 92, 92),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    ),
                    child: Slider(
                        value: _seconds,
                        max: 10,
                        min: 1,
                        divisions: 20,
                        inactiveColor: Colors.black12,
                        activeColor: Colors.grey,
                        thumbColor: Color.fromARGB(255, 92, 92, 92),

                        // label: _seconds.round().toString(),
                        onChanged: ((value) =>
                            setState(() => _seconds = value))),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (await Vibration.hasVibrator() ?? false) {
                        Vibration.vibrate(
                          // pattern: pattern,
                          amplitude: 255,
                          duration: _seconds.round() * 1000,
                        );
                      }
                    },
                    icon:
                        Icon(Icons.rocket_launch, color: Colors.grey, size: 50))
              ],
            ),
          ),
        ],
      )),
    );
  }
}

const Patterns = [
  [500, 1000],
  [500, 500],
  [500, 750, 1000],
  [750, 500, 250, 1000]
];
