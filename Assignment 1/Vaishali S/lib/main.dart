import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      
      home: MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
  Widget makeButton(String text, Color btnColor, double fontSize,BuildContext context) {
    return Container(
      width:double.infinity,
      child: ElevatedButton(
        
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
          
          
        ),
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          side: BorderSide(color: Colors.white)
        ),
        
        
        onPressed: () {},
      ),
    );
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
        title: Text(
          'Simple Calculator',
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '0',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '0',
                style: TextStyle(
                    fontSize: 55.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(child: Divider()),
          Container(
            child: Table(
              border: TableBorder.all(color: Colors.white),
              children: [
                TableRow(children: [
                  makeButton("C", Colors.red.shade400,35, context),
                  Container(
                    color: Colors.blue.shade400,
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Icon(Icons.backspace_outlined),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blue.shade400,side: BorderSide(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                  makeButton("÷", Colors.blue.shade400,35, context),
                  makeButton("x", Colors.blue.shade400,35, context),
                  
                  
                ]),
                TableRow(children:[
                  makeButton("7", Colors.grey.shade600, 35, context),
                  makeButton("8", Colors.grey.shade600, 35, context),
                  makeButton("9", Colors.grey.shade600, 35, context),
                  makeButton("-", Colors.blue.shade400, 35, context),
                ] ),
                TableRow(children:[
                  makeButton("4", Colors.grey.shade600, 35, context),
                  makeButton("5", Colors.grey.shade600, 35, context),
                  makeButton("6", Colors.grey.shade600, 35, context),
                  makeButton("+", Colors.blue.shade400, 35, context),
                ] ),
                TableRow(children:[
                  Column(children: [
                    makeButton("1", Colors.grey.shade600, 35, context),
                    makeButton(".", Colors.grey.shade600, 35, context),
                  ],),
                  Column(children: [
                    makeButton("2", Colors.grey.shade600, 35, context),
                    makeButton("0", Colors.grey.shade600, 35, context),
                  ],),
                  Column(children: [
                    makeButton("3", Colors.grey.shade600, 35, context),
                    makeButton("00", Colors.grey.shade600, 35, context),
                  ],),
                  Column(
                  
                    children: [ 
                    Container(height: MediaQuery.of(context).size.width*0.33,child: makeButton("=", Colors.red.shade600, 35, context)),
                    
                  ],)
                ] ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
