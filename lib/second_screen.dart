import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Second Screen',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                wordSpacing: 10,
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      'screen_3'); //here we just call the name of the screen3
                },
                child: const Text(
                  'Go To Third Screen',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
