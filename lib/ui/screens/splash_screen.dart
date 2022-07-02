import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/ui/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            width: 250.0,
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: false,
                  animatedTexts: [
                    FlickerAnimatedText('THE FUTURE',
                        textAlign: TextAlign.center),
                    FlickerAnimatedText('IS HERE', textAlign: TextAlign.center),
                    FlickerAnimatedText('SMART HOME',
                        textAlign: TextAlign.center),
                  ],
                  totalRepeatCount: 1,
                  onFinished: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
