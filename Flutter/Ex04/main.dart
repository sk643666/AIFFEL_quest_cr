import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Your Lucky Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page0(),
    );
  }
}

class NextButton extends StatelessWidget {
  final Widget nextPage;

  const NextButton({super.key, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Next'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
    );
  }
}

class Page0 extends StatelessWidget {
  const Page0({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '행운의 숫자를 찾아서!',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              NextButton(nextPage: Page1())
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration getGradientBackground(List<Color> colors) {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

class NumberPage extends StatelessWidget {
  final String number;
  final List<Color> gradientColors;
  final Widget nextPage;

  const NumberPage(
      {super.key,
      required this.number,
      required this.gradientColors,
      required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: getGradientBackground(gradientColors),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              NextButton(nextPage: nextPage)
            ],
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '1',
      gradientColors: [Colors.red, Colors.orange],
      nextPage: Page2(),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '2',
      gradientColors: [Colors.orange, Colors.yellow],
      nextPage: Page3(),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '3',
      gradientColors: [Colors.yellow, Colors.green],
      nextPage: Page4(),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '4',
      gradientColors: [Colors.green, Colors.blue],
      nextPage: Page5(),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '5',
      gradientColors: [Colors.blue, Colors.indigo],
      nextPage: Page6(),
    );
  }
}

class Page6 extends StatelessWidget {
  const Page6({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPage(
      number: '6',
      gradientColors: [Colors.indigo, Colors.purple],
      nextPage: Page7(),
    );
  }
}

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '7!\n행운의 숫자를 찾으셨습니다.\n앞으로도 행운이 있길 바라요!',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
