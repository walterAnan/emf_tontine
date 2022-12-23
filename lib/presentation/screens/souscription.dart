
import 'package:emf_tontine/presentation/screens/clients.dart';
import 'package:emf_tontine/presentation/screens/nav_bar_menu.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:flutter/material.dart';


class Souscription extends StatefulWidget {
  const Souscription({Key? key}) : super(key: key);

  @override
  _SouscriptionState createState() => _SouscriptionState();
}

class _SouscriptionState extends State<Souscription> with SingleTickerProviderStateMixin{
  late TabController tb;
  bool shouldPop = true;
  @override
  void initState() {
    super.initState();
    tb=TabController(length: 2, vsync: this);
    tb.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  //


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(title: "Home",),
          body: Container(
            padding: const EdgeInsets.only(bottom: 12),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            //back bt
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              top: 0,
                              bottom: 0,
                              start: 7,
                              child: InkWell(
                                onTap: (){
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  // padding: const EdgeInsets.all(10.0),
                                  child: Image.asset("assets/newIcons/ic_menu.png",width: 25,
                                    color: Theme.of(context).iconTheme.color,),
                                ),
                              ),
                            ),
                            //Center Widget
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              top: 0,
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text("Souscriptions",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'medium',
                                     color: Colors.blue,
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      //TabBar
                      // Container(
                      //   height: 30,
                      //   padding: EdgeInsets.only(left: 9,right: 9),
                      //   child: TabBar(
                      //      unselectedLabelColor: Colors.black,
                      //     indicatorWeight: 0.1,
                      //     indicatorSize: TabBarIndicatorSize.tab,
                      //     dragStartBehavior: DragStartBehavior.start,
                      //     labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      //     indicator: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     //  isScrollable: true,
                      //
                      //     tabs: [
                      //       Tab(
                      //           child: tabItem(0,"Nouveau Client")
                      //       ),
                      //       Tab(
                      //           child: tabItem(1,"Ancien Client")
                      //       ),
                      //     ],
                      //     controller: tb,
                      //   ),
                      // ),
                      //Tababar View
                      const SizedBox(height: 7),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            physics: const ClampingScrollPhysics(),
                            children: const [
                             RegisterClient(),
                              Clients()
                            ],
                            controller: tb,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Floating Action Button
                /*Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 5,
                  bottom: 25,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, SlidePageRoute(page: Chat()));
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentTextTheme.headline1.color,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/newIcons/ic_chat.png",)
                            )
                        ),
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
  Container tabItem(int index,String title){
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width/2;
    return Container(
      width: tabWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tb.index == index
              ? Colors.green
              : Colors.white
      ),
      child: Text(title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'medium',
        ),),
    );
  }
}