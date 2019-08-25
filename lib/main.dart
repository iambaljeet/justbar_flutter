import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageValue = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      currentPageValue = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 9,
              child: PageView(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  getChangedPageAndMoveBar(page);
                },
                children: <Widget>[
                  mainView(
                      'assets/images/tutorial_image_1.png',
                      'It’s available in your favorite cities now'
                          'and thy wait! go and order'
                          'four favorite juices'),
                  mainView(
                      'assets/images/tutorial_image_2.png',
                      'Juice is a beverage made from the'
                          'extraction or pressing out of natural liquid'
                          'contained good quality fruits'
                          'four favorite juices'),
                  mainView(
                      'assets/images/tutorial_image_3.png',
                      'User can look for their favorite juices'
                          'and buy it through the online gateway'
                          'process or through cash on delivery')
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 3; i++)
                          if (i == currentPageValue) ...[
                            pageIndicator(true)
                          ] else
                            pageIndicator(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text('SKIP'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget pageIndicator(bool isActive) {
  return Container(
    height: 10,
    width: 30,
    margin: EdgeInsets.only(left: 10, right: 10),
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? colorActive : colorInactive,
        borderRadius: BorderRadius.all(
          Radius.elliptical(4, 4),
        ),
      ),
    ),
  );
}

Widget mainView(image, title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          fit: BoxFit.none,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    ),
  );
}
