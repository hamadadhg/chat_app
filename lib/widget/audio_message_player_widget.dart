/*
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class AudioMessagePlayerWidget extends StatefulWidget {
  final String audioUrl;
  const AudioMessagePlayerWidget({
    super.key,
    required this.audioUrl,
  });

  @override
  State<AudioMessagePlayerWidget> createState() =>
      _AudioMessagePlayerWidgetState();
}

class _AudioMessagePlayerWidgetState extends State<AudioMessagePlayerWidget> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  double sliderValue = 0;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen(
      (
        PlayerState state,
      ) {
        setState(
          () {
            isPlaying = state == PlayerState.playing;
          },
        );
      },
    );
    audioPlayer.onDurationChanged.listen(
      (
        Duration d,
      ) {
        setState(
          () {
            duration = d;
          },
        );
      },
    );
    audioPlayer.onPositionChanged.listen(
      (Duration p) {
        setState(
          () {
            position = p;
            sliderValue = p.inSeconds.toDouble();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    bool isPlaying = (audioPlayer.state == PlayerState.playing);

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(
        UrlSource(
          widget.audioUrl,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: togglePlayPause,
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: kWhiteColor,
          ),
        ),
        Expanded(
          child: Slider(
            value: duration.inSeconds > 0 ? position.inSeconds.toDouble() : 0,
            min: 0,
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) async {
              final newPosition = Duration(
                seconds: value.toInt(),
              );
              await audioPlayer.seek(
                newPosition,
              );
            },
          ),
        ),
      ],
    );
  }
}
*/
