import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(children: <Widget>[
        Container(
            width: 600,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
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
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text('User ID',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(icon: Icon(Icons.edit))
                      ])),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text('User Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(icon: Icon(Icons.edit))
                      ])),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text('User Email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(icon: Icon(Icons.edit))
                      ])),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Text('Posts',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ])),
                  ),
                ])),

                Container(
                  margin: EdgeInsets.all(8),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(10, (index){
                      return Container(
                        padding: EdgeInsets.all(4),
                        child: Image.network("https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")
                      );
                    })
                  ),
                )
      ]),
    );
  }
}
