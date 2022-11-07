import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreditCard(),
    );
  }
}

class CreditCard extends StatefulWidget {
  CreditCard({Key? key}) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          // color: Color.fromARGB(255, 230, 228, 232),
          child: CardSlider(height: MediaQuery.of(context).size.height * .6),
        ),
      ),
    );
  }
}

class CardSlider extends StatefulWidget {
  final double height;
  const CardSlider({super.key, required this.height});

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late double positionY_line1;
  late double positionY_line2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    positionY_line1 = widget.height * 0.15;
    positionY_line2 = positionY_line1 + 200;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 230, 228, 232),
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "YOUR SECURED CARD",
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )
        // * line 1
        ,
        Positioned(
          top: positionY_line1,
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
        ),

        // * line 2
        Positioned(
          top: positionY_line2,
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
        )
      ]),
    );
  }
}
