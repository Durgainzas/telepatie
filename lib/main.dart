import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telepatie Dice',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Telepatie Dice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = new TextEditingController();

  String symbol = "";
  int roll = 0 ;
  int fields = 0;
  int inNr = 0;
  String input = "0";
  bool inputEnabled = true;
  int fieldsPC = 50;
  int fieldsPlayer = 50;
  String header = "";

  Random random = new Random();

  void _rollBaby() {
    roll = random.nextInt(2);
    fields = random.nextInt(5) + 5;
    if (input.isEmpty) input = "0";

    setState(() {
      if (roll == 0) {
        symbol = "Obrazek";
        inNr = int.parse(input);
        fieldsPlayer = fieldsPlayer - inNr;
        fieldsPC -= 2;
      }

      if (roll == 1)
      {
          symbol = "Slovo";
          inNr = int.parse(input);
          fieldsPlayer = fieldsPlayer - inNr;
          fieldsPC -= 4;
      }

      if (fieldsPC < 1)
      {
          header = "Konec hry! Vyhr??l po????ta??!";
          fieldsPC = 0;
          inputEnabled = false;
      }

      if (fieldsPlayer < 1 && fieldsPC > 0)
      {
          header = "Konec hry! Vyhr??l hr????!";
          fieldsPlayer = 0;
          inputEnabled = false;
      }

      // for (int i = 50; i > 0; i--)
      // {
      //     if (i == fieldsPC) pcPath += "P ";
      //     else pcPath += "_ ";
      // }

      // for (int i = 50; i > 0; i--)
      // {
      //     if (i == fieldsPlayer) playerPath += "H ";
      //     else playerPath += "_ ";
      // }

      input = "0";
      _controller.text = "";

    });


  }

  void _reset() {
    setState(() {
      _controller.text = "";
      symbol = "";
      roll = 0 ;
      fields = 0;
      inNr = 0;
      input = "0";
      fieldsPC = 50;
      fieldsPlayer = 50;
      header = "";
      inputEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget> [
                Text(
                  'Po??et pol?? do konce:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Hr????: $fieldsPlayer',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'Po????ta??: $fieldsPC',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ]),
            Column(
              children: <Widget> [
                Text(
                  'Aktu??ln?? hod:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Typ: $symbol',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'Po??et pol??: $fields',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ]), 
            Column(
              children: <Widget> [
                Text(
                  'Kolik bylo shod:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: _controller,
                    enabled: inputEnabled,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    onChanged: (value) => input = value,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ]),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              TextButton(
                onPressed: _reset, 
                child: Column (
                  children: <Widget> [ 
                    Icon(Icons.refresh), 
                    Text('Reset'),
                  ]
                ),
              ),
              TextButton(
                onPressed: _rollBaby, 
                child: Column (
                  children: <Widget> [ 
                    Icon(Icons.play_arrow_sharp), 
                    Text('Hrej!'),
                  ]
                ),
              ),
            ]),
            Text(
              '$header',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _rollBaby,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.play_arrow_sharp),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
      
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.refresh), 
      //       label: "Restart",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.play_arrow_sharp), 
      //       label: "Hrej!",
      //     ),
      //   ],
      // ),
    );
  }
}
