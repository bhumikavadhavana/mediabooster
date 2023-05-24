import 'package:flutter/material.dart';

import 'views/music.dart';
import 'views/video.dart';

void main() {
  runApp(
    Mymusic(),
  );
}

class Mymusic extends StatefulWidget {
  const Mymusic({Key? key}) : super(key: key);

  @override
  State<Mymusic> createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( useMaterial3: true, ),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "SoundCloud",
                style: TextStyle(
                 fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
               labelPadding: EdgeInsets.only(left: 20, right: 20),
                tabs: [
                  Tab(
                    child: Text(
                      "Music",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                       ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Video",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                         ),
                    ),
                  ),
                ],
              ),
              elevation: 0,
            ),
            body: TabBarView(
              children: [
                Music(),
                Video(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
