import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSection extends StatefulWidget {
  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    child: Stack(
                      children: [
                        isPressed ? Liked() : NotLiked(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: new InkWell(
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                ),
                                onTap: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                            Container(
                              child: Text(
                                '15',
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(
                    width: 12.0,
                  ),
                  NotVerified()
                ],
              ),
              new Icon(
                FontAwesomeIcons.infoCircle,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22.0, 5.0, 0.0, 0.0),
          child: Text("26 March , 2020",
              style: GoogleFonts.roboto(
                  color: Colors.grey[500],
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}

class NotVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check,
      size: 20.0,
      color: Colors.green,
    );
  }
}

class NotLiked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: new Icon(FontAwesomeIcons.heart),
      color: Colors.red,
      iconSize: 20.0,
      onPressed: () {},
    );
  }
}

class Liked extends StatefulWidget {
  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> with TickerProviderStateMixin {
  double iconSize;
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    iconSize = 0.0;
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        lowerBound: 0.0,
        upperBound: 1.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        return IconButton(
          icon: new Icon(FontAwesomeIcons.solidHeart),
          color: Colors.red,
          iconSize: _curvedAnimation.value * 20.0,
          onPressed: () {},
        );
      },
    );
  }
}
