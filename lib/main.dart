import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:credit_card_animation/model/card_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontFamily: "ocr-a",
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

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  bool _confirm = false;
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: EdgeInsets.only(top: 60, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF0B258A),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100)),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.4)),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.white,
                      size: 20,
                    )),
                  ),
                  // Spacer(),
                  Text(
                    "Select Card",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.4),
                        image: DecorationImage(
                            image: AssetImage("assets/img.JPG"))),
                    // child: Center(child: ),
                  )
                ],
              ),
            ]),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .55,
              // color: Color.fromARGB(255, 230, 228, 232),
              // color: Colors.amber,
              child: SlideInDown(
                child: CardSlider(
                  height: MediaQuery.of(context).size.height * .6,
                  confirm: (confirm) {
                    _confirm = confirm;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardSlider extends StatefulWidget {
  final double height;
  final Function(bool) confirm;
  const CardSlider({
    Key? key,
    required this.height,
    required this.confirm,
  }) : super(key: key);

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late double positionY_line1;
  late double positionY_line2;
  late List<CardInfo> _cardInfoList;
  late double _middleAreaHeight;
  late double _outsiteCardInterval;
  late double scrollOffsetY;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    positionY_line1 = widget.height * 0.1;
    positionY_line2 = positionY_line1 + 200;
    widget.confirm(false);

    _middleAreaHeight = positionY_line2 - positionY_line1;
    _outsiteCardInterval = 30.0;
    scrollOffsetY = 0.0;

    _cardInfoList = [
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 234, 94, 190),
        rightColor: Color.fromARGB(255, 224, 63, 92),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 171, 51, 75),
        rightColor: Color.fromARGB(255, 224, 63, 92),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 10, 10, 10),
        rightColor: Color.fromARGB(255, 10, 10, 10),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 85, 137, 234),
        rightColor: Color.fromARGB(255, 10, 10, 10),
      ),
    ];

    for (int i = 0; i < _cardInfoList.length; i++) {
      CardInfo cardInfo = _cardInfoList[i];
      if (i == 0) {
        cardInfo.positionY = positionY_line1;
        cardInfo.opacity = 1.0;
        cardInfo.rotate = 1.0;
        cardInfo.scale = 1.0;
      } else {
        cardInfo.positionY = positionY_line2 + (i - 1) * 30;
        cardInfo.opacity = 0.7 - (i - 1) * 0.1;
        cardInfo.rotate = -60;
        cardInfo.scale = 0.9;
      }
    }

    _cardInfoList = _cardInfoList.reversed.toList();
  }

  _cardBuild() {
    List widgetList = [];

    for (CardInfo cardInfo in _cardInfoList) {
      widgetList.add(Positioned(
        top: cardInfo.positionY,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(pi / 180 * cardInfo.rotate)
            ..scale(cardInfo.scale),
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: cardInfo.opacity,
            child: Container(
              width: 300,
              height: 190,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 10,
                        offset: Offset(5, 10))
                  ],
                  color: Colors.red,
                  gradient: LinearGradient(
                      colors: [cardInfo.leftColor, cardInfo.rightColor])),
              child: Stack(children: [
                // * Number
                Positioned(
                  top: 130,
                  left: 20,
                  child: Text(
                    "5434 3443 654453",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.5,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                // * Card Name
                Positioned(
                  top: 160,
                  left: 20,
                  child: Text(
                    cardInfo.userName,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.5,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                // * sim card

                Positioned(
                  left: 0,
                  top: 70,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        // color: Colors.deepOrange,
                        child: Image.asset(
                          "assets/sim.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 25,
                        child: Image.asset(
                          "assets/signal.png",
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // * Card Logo
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset("assets/mastercardLogo.png"),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ));
    }

    return widgetList;
  }

  // * position update function

  void _updateCardPosition(double offsetY) {
    scrollOffsetY += offsetY;

    void updatePosition(CardInfo cardInfo, double firstCardAreaIdx, int index) {
      // cardInfo.positionY += offsetY;
      double currentCardAreaIdx = firstCardAreaIdx + index;
      if (currentCardAreaIdx < 0) {
        cardInfo.positionY = positionY_line1 + currentCardAreaIdx * 5;

        cardInfo.scale =
            1.0 - 0.2 / 10 * (positionY_line1 - cardInfo.positionY);

        if (cardInfo.scale < 0.8) cardInfo.scale = 0.8;
        if (cardInfo.scale > 1) cardInfo.scale = 1.0;

        // * rotate card
        cardInfo.rotate = -90.0 / 5 * (positionY_line1 - cardInfo.positionY);

        if (cardInfo.rotate > 0.0) cardInfo.rotate = 0.0;
        if (cardInfo.rotate < -90.0) cardInfo.rotate = -90.0;

        // Opacity 1.0 --> 0.7
        cardInfo.opacity =
            1.0 - 0.7 / 5 * (positionY_line1 - cardInfo.positionY);

        if (cardInfo.opacity < 0.0) cardInfo.opacity = 0.0;
        if (cardInfo.opacity > 1) cardInfo.opacity = 1.0;
      } else if (currentCardAreaIdx >= 0 && currentCardAreaIdx < 1) {
        cardInfo.scale = 1.0 -
            0.1 /
                (positionY_line2 - positionY_line1) *
                (cardInfo.positionY - positionY_line1);
        if (cardInfo.scale < 0.9) cardInfo.scale = 0.9;
        if (cardInfo.scale > 1) cardInfo.scale = 1.0;
        // move 1:1
        cardInfo.positionY =
            positionY_line1 + currentCardAreaIdx * _middleAreaHeight;
        // * rotate card
        cardInfo.rotate = -60.0 /
            (positionY_line2 - positionY_line1) *
            (cardInfo.positionY - positionY_line1);
        if (cardInfo.rotate > 0.0) cardInfo.rotate = 0.0;
        if (cardInfo.rotate < -60.0) cardInfo.rotate = -60.0;

        // Opacity
        cardInfo.opacity = 1.0 -
            0.3 /
                (positionY_line2 - positionY_line1) *
                (cardInfo.positionY - positionY_line1);
        if (cardInfo.opacity < 0.0) cardInfo.opacity = 0.0;
        if (cardInfo.opacity > 1) cardInfo.opacity = 1.0;
      } else if (currentCardAreaIdx >= 1) {
        cardInfo.positionY =
            positionY_line2 + (currentCardAreaIdx - 1) * _outsiteCardInterval;
        cardInfo.rotate = -60.0;
        cardInfo.scale = 0.9;
        cardInfo.opacity = 0.7;
      }
    }

    double firstCardAreaIdx = scrollOffsetY / _middleAreaHeight;
    print(firstCardAreaIdx);
    setState(() {
      // CardInfo cardInfo = _cardInfoList.last;
      // updatePosition(cardInfo, firstCardAreaIdx, 0);
    });

    for (int i = 0; i < _cardInfoList.length; i++) {
      CardInfo cardInfo = _cardInfoList[_cardInfoList.length - 1 - i];
      updatePosition(cardInfo, firstCardAreaIdx, i);
      setState(() {
        // cardInfo.positionY += offsetY;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails d) {
        // print(d.delta.dy);

        _updateCardPosition(d.delta.dy);
      },
      onVerticalDragEnd: (DragEndDetails d) {
        scrollOffsetY =
            (scrollOffsetY / _middleAreaHeight).round() * _middleAreaHeight;
        _updateCardPosition(0);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        // color: Color.fromARGB(255, 230, 228, 232),
        decoration: BoxDecoration(
            color: Color(0xFF0B258A).withOpacity(.1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
        // color: Colors.amber,
        child: Stack(alignment: Alignment.topCenter, children: [
          // * top title
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
          // Positioned(
          //   top: positionY_line1,
          //   child: Container(
          //     height: 1,
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.red,
          //   ),
          // ),

          ..._cardBuild(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(0, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                  ])),
            ),
          ),
          // * line 2
          // Positioned(
          //   top: positionY_line2,
          //   child: Container(
          //     height: 1,
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.red,
          //   ),
          // ),

          // * bottom row
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.keyboard,
                      color: Colors.grey,
                      size: 35,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  TextButton(
                      onPressed: () {
                        widget.confirm(true);
                        print("tab");
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: ShapeDecoration(
                          shadows: [
                            BoxShadow(
                                color: Color(0xFF0B258A).withOpacity(.5),
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ],
                          shape: StadiumBorder(),
                          color: Color(0xFF0B258A),
                        ),
                        child: Center(
                          child: Text(
                            "Confirm \$5400",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.mic,
                      color: Colors.grey,
                      size: 35,
                    ),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
