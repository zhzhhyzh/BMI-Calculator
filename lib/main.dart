import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _bmi = 0.0;
  double _weight = 0;
  double _height = 0;

  String _bmiOutput = "";
  String _bmiImage = "assets/images/empty.png";

  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();

void _calculateBMI(){
  _weight = double.tryParse(_weightCtrl.text)!;
  _height = double.tryParse(_heightCtrl.text)!;

  setState(() {
    _bmi = _weight /(pow(_height, 2));
    if(_bmi < 18.5){
      _bmiImage = 'assets/images/under.png';
      _bmiOutput = '${_bmi.toStringAsFixed(2)} [Underweight]';
    } else if (_bmi < 25){
      _bmiImage = 'assets/images/normal.png';
      _bmiOutput = '${_bmi.toStringAsFixed(2)} [Normal]';
    } else {
      _bmiImage = 'assets/images/over.png';
      _bmiOutput = '${_bmi.toStringAsFixed(2)} [Overweight]';
    }
  });
}

void _resetScreen(){
  _weightCtrl.clear();
  _heightCtrl.clear();
  setState(() {
    _bmi=0;
    _bmiOutput='';
    _bmiImage='assets/images/empty.png';
  });
}

@override void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
        padding: const EdgeInsets.all(19.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              fit:StackFit.loose,
              alignment: AlignmentDirectional.center,
              children: [

                Container(
             width: 160,
             height: 160,
             decoration: BoxDecoration(
               border: Border.all(
                 color: Theme.of(context).colorScheme.inversePrimary,
                 width: 3,

               )
             ),
             child: Image.asset(
                 _bmiImage
             ),
           ),
            Container(
              width: 150,
              height: 150,
              alignment: AlignmentDirectional.center,
              child: _bmi == 0.0? Text(
                textAlign: TextAlign.center,
                "Enter your height and your weight accordingly to have your BMI",
                style: TextStyle(fontSize:12, color: Colors.blueAccent),
              ):Text("")
            )
          ],
        ),
            const Text(
              "Your BMI is:"
            ),
            Text(
              _bmiOutput,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            TextField(
              controller: _weightCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Weight(kg)"
              ),
            ),
            TextField(
              controller: _heightCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Enter Height(m)"
              ),

            ),
            Expanded(child: SizedBox(height: double.infinity)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _resetScreen, child: Text('Reset')),
                ElevatedButton(onPressed: _calculateBMI, child: Text('Calculate'))
              ]
            )
          ],
        ),
      ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
