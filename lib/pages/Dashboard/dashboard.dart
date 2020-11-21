import 'package:dsc_projects/pages/Dashboard/posts.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _postOpened = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _postOpened = false;
        });
        return false;
      },
      child: Container(
          color: Colors.white,
          child: (!_postOpened)
              ? ListView(children: <Widget>[
                  Container(
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
                              child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")))),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                                  child: Container(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                          Container(
                                            child: Text('User Name',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          ),
                                          Divider(
                                            color:Colors.black,
                                            endIndent:70
                                          ),
                                          Container(
                                            width: 300,
                                            child: Text('This is my wonderful bio This is my wonderful bio This is my wonderful bio ')),
                                      ])),
                                ),
                              ],
                            ),
                          ])),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Container(
                        child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: <Widget>[
                          Text('Posts',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ])),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(10, (index) {
                          return Container(
                              padding: EdgeInsets.all(4),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _postOpened = true;
                                    });
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (BuildContext context) => Posts()));
                                  },
                                  child: Image.network(
                                      "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")));
                        })),
                  )
                ])
              : Posts()),
    );
  }
}
