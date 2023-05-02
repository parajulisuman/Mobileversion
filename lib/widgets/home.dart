import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 160.0, top: 250),
            child: Column(
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        const Icon(
                          Icons.square_outlined,
                        )
                    ],
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: const Text(
              "TIC TAC TOE",
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Screen())
                );
              },
              child: const Text(
                "Play",
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
