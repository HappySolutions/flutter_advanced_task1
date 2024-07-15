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
      Playlist(audios: [
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
      ]),
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
                  getBtnWidget,
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '00:00 / 02:30',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                ],
              ),
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
}
