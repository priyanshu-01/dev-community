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
      backgroundColor: Colors.white,
      // centerTitle: true,
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
                  image: AssetImage('assets/images/logo.png'),
                )),
          ),
          Flexible(
            flex: 10,
            child: Container(
              // height: 20.0,
              // color: Colors.red,
              child:
                  //      Image(
                  //   image: AssetImage('assets/images/logoname.png'),
                  // )
                  AutoSizeText(
                'DEV COMMUNITY',
                style: GoogleFonts.raleway(color: Colors.black),
                maxLines: 1,
                maxFontSize: 15.0,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              // AutoSizeText(
              //   'Developer Student Clubs',
              //   style: TextStyle(color: Colors.black),
              //   maxLines: 1,
              //   maxFontSize: 15.0,
              // ),
              //     AutoSizeText(
              //       'Bharati Vidyapeeth University, Pune',
              //       style: TextStyle(color: Color(0xff969696)),
              //       maxLines: 1,
              //       minFontSize: 9.0,
              //       maxFontSize: 10.0,
              //     )
              //   ],
              // ),
            ),
          )
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
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.home,
                  ),
                  color: (currentPage == pages.HomePage)
                      ? Colors.blue
                      : Colors.white,
                  onPressed: () {
                    pageKey.currentState.setState(() {
                      currentPage = pages.HomePage;
                    });
                  },
                ),
                // new IconButton(
                //   icon: Icon(
                //     Icons.search,
                //   ),
                //   color: (currentPage == pages.Search)
                //       ? Colors.blue
                //       : Colors.white,
                //   onPressed: () {
                //     pageKey.currentState.setState(() {
                //       currentPage = pages.Search;
                //     });
                //   },
                // ),
                new IconButton(
                  icon: Icon(
                    Icons.add_box,
                  ),
                  color: (currentPage == pages.AddWork)
                      ? Colors.blue
                      : Colors.white,
                  onPressed: () {
                    pageKey.currentState.setState(() {
                      currentPage = pages.AddWork;
                    });
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.account_box,
                  ),
                  color: (currentPage == pages.Dashboard)
                      ? Colors.blue
                      : Colors.white,
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
