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
                    return Column(
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
                        getBtnWidget,
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          '${convertSeconds(snapshots.data!.currentPosition.inSeconds)} / ${convertSeconds(snapshots.data!.duration.inSeconds)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
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
