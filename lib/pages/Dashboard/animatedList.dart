import 'dart:async';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dsc_projects/Alert/rflutter_alert.dart';

import '../../mainPage.dart';
import 'dashboard.dart';

final GlobalKey<AnimatedListState> listKey = GlobalKey();

Widget buildRemovedItem(
    BuildContext context, int a, Animation<double> animation) {
  return BuildToBeRemovedItem(
    animation: animation,
    index: a,
  );
}

class MyAnimatedList extends StatefulWidget {
  @override
  _MyAnimatedListState createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        key: listKey,
        physics: BouncingScrollPhysics(),
        initialItemCount: postDocumentSnapshots.length,
        itemBuilder: (BuildContext context, int index, animation) =>
            BuildItem(context: context, index: index, animation: animation));
  }

  // _listKey.currentState.removeItem(
  //   popUpAdder - popUpRemover,
  //   (BuildContext context, Animation<double> animation) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {});
  //     return buildRemovedItem(context, popUpRemover - 1, animation);
  //   },
  //   duration: const Duration(milliseconds: 500),
  // );

}

// buildToBeRemovedItem(
// BuildContext context,
// int index,
// Animation<double> animation,
// ) {
//   return
// }

class BuildToBeRemovedItem extends StatefulWidget {
  final int index;
  final Animation<double> animation;
  BuildToBeRemovedItem({this.index, this.animation});
  @override
  _BuildToBeRemovedItemState createState() => _BuildToBeRemovedItemState();
}

class _BuildToBeRemovedItemState extends State<BuildToBeRemovedItem>
    with TickerProviderStateMixin {
  Animation<Offset> offsetAnimation;
  @override
  void initState() {
    // TODO: implement initState
    offsetAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      // alignment: Alignment.center,
      // scale: widget.animation,
      child: Card(
          color: Colors.grey[900],
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: <Widget>[
              (postDocumentSnapshots.length == 0)
                  ? Container()
                  : Post(doc: postDocumentSnapshots[widget.index]),
              GestureDetector(
                onTap: () {
                  Alert(
                      context: context,
                      title: 'Delete this post?',
                      style: AlertStyle(
                        backgroundColor: Colors.black,
                        titleStyle: GoogleFonts.ubuntu(color: Colors.white),
                      ),
                      buttons: [
                        DialogButton(
                            color: Colors.white,
                            child: Text('Yes'),
                            onPressed: () {
                              Navigator.pop(context);
                              myFirestore.deletePost(
                                  postDocumentSnapshots[widget.index]);
                              listKey.currentState.removeItem(
                                widget.index,
                                (BuildContext context,
                                    Animation<double> animation) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {});
                                  return buildRemovedItem(
                                      context, widget.index, animation);
                                },
                                duration: const Duration(milliseconds: 800),
                              );
                            }),
                        DialogButton(
                            color: Colors.white,
                            child: Text('No'),
                            onPressed: null)
                      ]).show();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          )),
    );
  }
}

class BuildItem extends StatelessWidget {
  final BuildContext context;
  final int index;
  final Animation<double> animation;
  BuildItem({
    this.context,
    this.index,
    this.animation,
  });
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      axisAlignment: -1.0,
      child: Card(
          color: Colors.grey[900],
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: <Widget>[
              Post(doc: postDocumentSnapshots[index]),
              GestureDetector(
                onTap: () {
                  Alert(
                      context: context,
                      title: 'Delete this post?',
                      style: AlertStyle(
                        backgroundColor: Colors.black,
                        titleStyle: GoogleFonts.ubuntu(color: Colors.white),
                      ),
                      buttons: [
                        DialogButton(
                            color: Colors.white,
                            child: Text('Yes'),
                            onPressed: () {
                              Navigator.pop(context);
                              myFirestore
                                  .deletePost(postDocumentSnapshots[index]);
                              listKey.currentState.removeItem(
                                index,
                                (BuildContext context,
                                    Animation<double> animation) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {});
                                  return buildRemovedItem(
                                      context, index, animation);
                                },
                                duration: const Duration(milliseconds: 900),
                              );
                              postDocumentSnapshots.removeAt(index);
                            }),
                        DialogButton(
                            color: Colors.white,
                            child: Text('No'),
                            onPressed: null)
                      ]).show();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
