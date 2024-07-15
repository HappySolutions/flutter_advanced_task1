import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() async {
    await assetsAudioPlayer.open(
      Playlist(
        audios: [
          Audio(
            "assets/sampl.mp3",
            metas: Metas(title: 'First Song'),
          ),
          Audio(
            "assets/sampl1.mp3",
            metas: Metas(title: 'Second Song'),
          ),
          Audio(
            "assets/sampl2.mp3",
            metas: Metas(title: 'Third Song'),
          ),
        ],
      ),
      autoStart: false,
      loopMode: LoopMode.playlist,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(children: [
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Center(
              child: StreamBuilder(
                  stream: assetsAudioPlayer.realtimePlayingInfos,
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            assetsAudioPlayer.getCurrentAudioTitle == ''
                                ? 'Please play your Songs'
                                : assetsAudioPlayer.getCurrentAudioTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: snapshots.data?.current?.index == 0
                                    ? null
                                    : () {
                                        assetsAudioPlayer.previous();
                                      },
                                icon: const Icon(Icons.skip_previous),
                              ),
                              getBtnWidget,
                              IconButton(
                                onPressed: snapshots.data?.current?.index ==
                                        (assetsAudioPlayer
                                                    .playlist?.audios.length ??
                                                0) -
                                            1
                                    ? null
                                    : () {
                                        assetsAudioPlayer.next();
                                      },
                                icon: const Icon(Icons.skip_next),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Slider(
                            value: snapshots.data?.currentPosition.inSeconds
                                    .toDouble() ??
                                0.0,
                            onChanged: (value) async {
                              await assetsAudioPlayer.seek(
                                Duration(seconds: value.toInt()),
                              );
                              setState(() {});
                            },
                            min: 0,
                            max:
                                snapshots.data?.duration.inSeconds.toDouble() ??
                                    0.0,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${convertSeconds(snapshots.data?.currentPosition.inSeconds ?? 0)} / ${convertSeconds(snapshots.data?.duration.inSeconds ?? 0)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }

  Widget get getBtnWidget => assetsAudioPlayer.builderIsPlaying(
        builder: (context, isPlaying) {
          return FloatingActionButton.large(
            onPressed: () {
              if (isPlaying) {
                assetsAudioPlayer.pause();
              } else {
                assetsAudioPlayer.play();
              }
              setState(() {});
            },
            shape: const CircleBorder(),
            child: assetsAudioPlayer.builderIsPlaying(
              builder: (context, isPlaying) {
                return Icon(isPlaying ? Icons.pause : Icons.play_arrow);
              },
            ),
          );
        },
      );
  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsStr = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsStr.padLeft(2, '0')}';
  }
}
