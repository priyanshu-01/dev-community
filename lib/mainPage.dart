import 'package:dsc_projects/commonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/pages/AddWork/addWork.dart';
import 'package:dsc_projects/pages/Dashboard/dashboard.dart';
import 'package:dsc_projects/pages/Home/home.dart';
import 'package:dsc_projects/pages/Search/search.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firestore.dart';

FirestoreFunctions firestore;
CommonFunctions commonFunctions;

GlobalKey pageKey = GlobalKey();
enum pages { HomePage, Search, AddWork, Dashboard }
var currentPage = pages.HomePage;

Map<dynamic, Widget> getPage = {
  pages.AddWork: AddWork(),
  pages.Dashboard: Dashboard(),
  pages.HomePage: HomePage(),
  pages.Search: Search()
};

class MainPageWithAppBar extends StatefulWidget {
  MainPageWithAppBar() : super(key: pageKey);
  @override
  _MainPageWithAppBarState createState() => _MainPageWithAppBarState();
}

class _MainPageWithAppBarState extends State<MainPageWithAppBar> {
  @override
  void initState() {
    // firestore = new Firestore();
    commonFunctions = new CommonFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var topBar = new AppBar(
      backgroundColor: Colors.black,
      elevation: 2.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Container(
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage('assets/images/applogo.png'),
                  color: Colors.white,
                )),
          ),
          Flexible(
            flex: 10,
            child: Container(
              child: Image.asset('assets/images/appname.png',height:17,color: Colors.white,)
            ),
          ),
        ],
      ),
      actions: <Widget>[],
    );
    return new Scaffold(
        appBar: topBar,
        body: getPage[currentPage],
        bottomNavigationBar: new Container(
          color: Colors.black,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            color: Colors.black,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  color: (currentPage == pages.HomePage)
                      ? Colors.white
                      : Colors.grey[700],
                  onPressed: () {
                    pageKey.currentState.setState(() {
                      currentPage = pages.HomePage;
                    });
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.add_box,
                    size: 30,
                  ),
                  color: (currentPage == pages.AddWork)
                      ? Colors.white
                      : Colors.grey[700],
                  onPressed: () {
                    pageKey.currentState.setState(() {
                      currentPage = pages.AddWork;
                    });
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.account_box,
                    size: 30,
                  ),
                  color: (currentPage == pages.Dashboard)
                      ? Colors.white
                      : Colors.grey[700],
                  onPressed: () {
                    pageKey.currentState.setState(() {
                      currentPage = pages.Dashboard;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
