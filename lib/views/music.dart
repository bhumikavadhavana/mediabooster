import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mediabooster/utils/music_utils.dart';
import 'package:mediabooster/views/Musicpage.dart';
import 'package:carousel_slider/carousel_controller.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  CarouselController carouselController = CarouselController();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: 380,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
                onPageChanged: (val, _) {
                  setState(() {
                    i = val;
                  });
                }),
            items: MyMusicList.map((e) => Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(e['Image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Music_Page(
                                    AName: e['AName'],
                                    Image: e['Image'],
                                    Music: e['Music'],
                                    Name: e['Mname'],
                                  )));
                        },
                        icon: Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.white.withOpacity(0.7),
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                )).toList(),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
