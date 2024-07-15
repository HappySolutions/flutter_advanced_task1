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
                  const Text(
                    'Song Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.large(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.play_arrow,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
}
/*
IconButton(
          onPressed: () async {
            await assetsAudioPlayer.open(
              Playlist(audios: [
                Audio("assets/sampl.mp3"),
                Audio("assets/sampl1.mp3"),
                Audio("assets/sampl2.mp3"),
              ]),
            );
            setState(() {});
          },
          icon:
              assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
            return Icon(isPlaying ? Icons.pause : Icons.play_arrow);
          }),
        ),
 */
