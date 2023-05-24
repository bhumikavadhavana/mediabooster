import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:mediabooster/utils/music_utils.dart';

class Music_Page extends StatefulWidget {
  String Music;
  String AName;
  String Name;
  String Image;

  Music_Page(
      {Key? key,
        required this.Image,
        required this.Name,
        required this.AName,
        required this.Music})
      : super(key: key);

  @override
  State<Music_Page> createState() => _Music_PageState();
}

class _Music_PageState extends State<Music_Page> with TickerProviderStateMixin {
  AssetsAudioPlayer MyAudio = AssetsAudioPlayer();
  Duration max = Duration.zero;
  AnimationController? MyIconcontroller;
  SliderComponentShape? mythumb = SliderComponentShape.noThumb;

  @override
  void initState() {
    super.initState();
    MyAudio.open(
      Playlist(
        audios: MyMusicList.map((e) => Audio(
          widget.Music,
        )).toList(),
      ),
      showNotification: true,
      autoStart: false,
    ).then((_) => setState(() {
      max = MyAudio.current.value!.audio.duration;
    }));

    MyIconcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  bool play = true;

  @override
  void dispose() {
    super.dispose();
    MyAudio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.Name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            widget.Image,
            fit: BoxFit.cover,
            height: 790,
            opacity: const AlwaysStoppedAnimation(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      widget.Image,
                    )),
                Text(
                  widget.Name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Text(
                  widget.AName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        return IconButton(
                            onPressed: () {
                              MyAudio.stop();
                            },
                            icon: const Icon(
                              Icons.stop,
                              size: 30,
                            ));
                      },
                    ),
                    StreamBuilder(
                      stream: MyAudio.isPlaying,
                      builder: (context, snapshot) {
                        var val = snapshot.data;
                        val == true
                            ? MyIconcontroller!.forward()
                            : MyIconcontroller!.reverse();

                        return IconButton(
                            onPressed: () {
                              if (val == true) {
                                MyAudio.pause();
                              } else {
                                MyAudio.play();
                              }
                            },
                            icon: AnimatedIcon(
                              progress: MyIconcontroller!,
                              size: 60,
                              icon: AnimatedIcons.play_pause,
                            ));
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          if (play == true) {
                            MyAudio.setVolume(00);
                            setState(() {
                              play = !play;
                            });
                          } else {
                            MyAudio.setVolume(100);
                            setState(() {
                              play = !play;
                            });
                          }
                        },
                        icon: play
                            ? const Icon(
                          Icons.headphones,
                          size: 30,
                        )
                            : const Icon(
                          Icons.headset_off,
                          size: 30,
                        )),
                  ],
                ),
                StreamBuilder(
                    stream: MyAudio.currentPosition,
                    builder: (context, snapshot) {
                      Duration? data = snapshot.data;
                      return SliderTheme(
                        data: SliderThemeData(
                            thumbShape: mythumb,
                          ),
                        child: Slider(
                          min: 0,
                          max: max.inSeconds.toDouble(),
                          onChangeStart: (val) {
                            setState(() {
                              mythumb = null;
                            });
                          },
                          value: data == null ? 0 : data.inSeconds.toDouble(),
                          onChangeEnd: (val) {
                            setState(() {
                              mythumb = SliderComponentShape.noThumb;
                            });
                          },
                          onChanged: (val) {
                            setState(() {
                              MyAudio.seek(Duration(seconds: val.toInt()));
                            });
                          },
                        ),
                      );
                    }),
                StreamBuilder(
                  stream: MyAudio.currentPosition,
                  builder: (context, snapshot) {
                    var val = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${val!.inMinutes}:${val.inSeconds % 60}",
                          ),
                          Text(
                            "${max.inMinutes}:${max.inSeconds % 60}",
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
