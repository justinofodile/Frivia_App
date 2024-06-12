// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:triviaa/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficultyLevel = 0;
  final List _difficultyText = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceHeight! * 0.10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              homeText(),
              difficultySlider(),
              startGameButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeText() {
    return Column(
      children: [
        const Text(
          "Frivia Jay",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyText[_currentDifficultyLevel.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget difficultySlider() {
    return Slider(
      label: "Difficulty",
      divisions: 2,
      min: 0,
      max: 2,
      value: _currentDifficultyLevel,
      onChanged: (_value) {
        setState(() {
          _currentDifficultyLevel = _value;
        });
      },
    );
  }

  Widget startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext _context) {
              return GamePage(
                difficultyLevel:
                    _difficultyText[_currentDifficultyLevel.toInt()]
                        .toLowerCase(),
              );
            },
          ),
        );
      },
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      color: Colors.blue,
      child: const Text(
        "Start Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
