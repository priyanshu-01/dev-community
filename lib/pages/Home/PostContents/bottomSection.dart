import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:intl/intl.dart';

class BottomSection extends StatefulWidget {
  final doc;
  BottomSection({this.doc});

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  int likesCount;
  bool isLiked;

  @override
  void initState() {
    super.initState();
    likesCount = 0;
    isLiked = false;
    if (widget.doc.data()['likes'] != null) {
      likesCount =
          commonFunctions.getMapLengthWhereNotNull(widget.doc.data()['likes']);
      isLiked = widget.doc.data()['likes'][firestore.uid] == true;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime ts = widget.doc.data()['timestamp'].toDate();
    String time = DateFormat.yMMMd().add_jm().format(ts).toString();
    var d = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: [
                        isLiked ? Liked() : NotLiked(),
                        Positioned(
                          left: 1.0,
                          right: 1.0,
                          bottom: 0.0,
                          child: Column(
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
                                      isLiked = !isLiked;
                                      if (isLiked) {
                                        firestore.likePost(widget.doc);
                                        likesCount = likesCount + 1;
                                      } else {
                                        firestore.unlikePost(widget.doc);
                                        likesCount = likesCount - 1;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: Text(
                                  likesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.white,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: Text(time,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 12.0,
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

// class NotLiked1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6.0),
//       child: IconButton(
//         icon: new Icon(FontAwesomeIcons.heart),
//         color: Colors.pink,
//         iconSize: 20.0,
//         onPressed: () {},
//       ),
//     );
//   }
// }

class NotLiked extends StatefulWidget {
  @override
  _NotLikedState createState() => _NotLikedState();
}

class _NotLikedState extends State<NotLiked> with TickerProviderStateMixin {
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: IconButton(
            icon: new Icon(FontAwesomeIcons.heart),
            color: Colors.pink,
            iconSize: _curvedAnimation.value * 20.0,
            onPressed: () {},
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: IconButton(
            icon: new Icon(FontAwesomeIcons.solidHeart),
            color: Colors.pink,
            iconSize: _curvedAnimation.value * 20.0,
            onPressed: () {},
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
