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
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // height: 20.0,
                    // width: 20.0,
                    child: Stack(
                      children: [
                        isPressed ? Liked() : NotLiked(),
                        new InkWell(
                          // child: isPressed ? Liked() : NotLiked(),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            // color: Colors.amber,
                          ),
                          onTap: () {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
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
                // color: Colors.yellow[600],
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
      onPressed: () {},
    );
  }
}

class Liked extends StatefulWidget {
  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return
        // IconButton(
        //   icon: new Icon(FontAwesomeIcons.solidHeart),
        //   color: Colors.red,
        //   iconSize: 20.0,
        //   onPressed: () {},
        // );
        AnimatedSize(
      duration: Duration(milliseconds: 1000),
      vsync: this,
      curve: Curves.bounceInOut, alignment: Alignment.center,
      child: IconButton(
        icon: new Icon(FontAwesomeIcons.solidHeart),
        color: Colors.red,
        iconSize: 20.0,
        onPressed: () {},
      ),
      //     Container(
      //   // height: 20.0,
      //   // width: 20.0,
      //   color: Colors.yellow,
      // )
    );
  }
}
