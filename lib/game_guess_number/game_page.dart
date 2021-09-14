import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game _game;
  final TextEditingController _controller = TextEditingController();
  String? _guessnumber;
  String? _feedback;
  bool checkwin = false;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void newgame() {
    setState(() {
      _game = Game();
      checkwin = false;
      _guessnumber = null;
      _feedback = '';
    });
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("GOOD JOB!"),
          content: Text(
              "The answer is ${_game.getanswer()} \nyou have made ${_game.totalGuess} guess\n\n${_game.getdata()}"),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GUESS THE NUMBER",
          style: GoogleFonts.kanit(fontSize: 20.0, color: Colors.black),
        ),
        backgroundColor: Colors.red.shade100,
      ),
      body: Container(
        color: Colors.yellow.shade100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildColumn(), _buildMainContent(), _buildRow()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return _guessnumber == null
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Guess the number \nbetween 1 - 100 ?',
          style: GoogleFonts.kanit(fontSize: 30.0),
          textAlign: TextAlign.center,
        )
      ],
    )
        : checkwin
        ? winguess()
        : loseguess();
  }

  Widget loseguess() {
    return Column(
      children: [
        Text(
          _guessnumber!,
          style: GoogleFonts.kanit(fontSize: 80.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.clear, // รูปไอคอน
              size: 40.0, // ขนาดไอคอน
              color: Colors.red, // สีไอคอน
            ),
            Text(
              _feedback!,
              style: GoogleFonts.kanit(fontSize: 40.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget winguess() {
    return Column(
      children: [
        Text(
          _guessnumber!,
          style: GoogleFonts.kanit(fontSize: 80.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check, // รูปไอคอน
              size: 40.0, // ขนาดไอคอน
              color: Colors.green, // สีไอคอน
            ),
            Text(
              _feedback!,
              style: GoogleFonts.kanit(fontSize: 40.0),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: (newgame),
          style: ElevatedButton.styleFrom(
            primary: Colors.red.shade100, // background
            onPrimary: Colors.black, // foreground
          ),
          child: Text(
            'NEW GAME',
            style: GoogleFonts.kanit(fontSize: 15.0),
          ),
        ),
      ],
    );
  }

  Widget _buildRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        border: Border.all(width: 5.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Enter the number here',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _guessnumber = _controller.text;

                  int? guess = int.tryParse(_guessnumber!);
                  if (guess != null) {
                    _controller.clear();
                    var result = _game.doGuess(guess);
                    if (result == 0) {
                      _showMaterialDialog();
                      _feedback = 'CORRECT!';
                      checkwin = true;
                    } else if (result == 1) {
                      _feedback = 'TOO HIGH!';
                      checkwin = false;
                    } else {
                      _feedback = 'TOO LOW!';
                      checkwin = false;
                    }
                  }
                });
              },
              child: Text('GUESS'),
              style: TextButton.styleFrom(backgroundColor: Colors.red.shade100),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 260.0,
        ),
        Text(
          'GUESS THE NUMBER',
          style: GoogleFonts.kanit(fontSize: 30.0),
        ),
      ],
    );
  }
}
