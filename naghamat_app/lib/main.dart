import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[300],
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Naghamat'),
        ),
        body: const MusicWidget(),
      ),
    );
  }
}

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  final AudioPlayer _player = AudioPlayer();
  String? _currentTrack;
  bool isPaused = true;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final List<Map<String, String>> musicList = [
    {'title': 'My 1st Music', 'path': 'music-1.mp3'},
    {'title': 'My 2nd Music', 'path': 'music-2.mp3'},
    {'title': 'My 3rd Music', 'path': 'music-3.mp3'},
    {'title': 'My 4th Music', 'path': 'music-4.mp3'},
    {'title': 'My 5th Music', 'path': 'music-5.mp3'},
    {'title': 'My 6th Music', 'path': 'music-6.mp3'},
    {'title': 'My 7th Music', 'path': 'music-7.mp3'},
  ];

  @override
  void initState() {
    super.initState();

    // Listen for duration updates
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
      print("Duration Updated: $_duration");
    });

    // Listen for position updates
    _player.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
      print("Position Updated: $_position");
    });
  }

  void playMusic(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path));

    // Explicitly get the duration
    await Future.delayed(
        const Duration(seconds: 1)); // Allow time for player to load
    final duration = await _player.getDuration();

    setState(() {
      _currentTrack = path;
      isPaused = false;
      _duration = duration ?? Duration.zero;
      _position = Duration.zero;
    });

    print("Duration Retrieved: $_duration");
  }

  void pauseMusic() async {
    await _player.pause();
    setState(() {
      isPaused = true;
    });
  }

  void resumeMusic() async {
    await _player.resume();
    setState(() {
      isPaused = false;
    });
  }

  void seekToPosition(double seconds) {
    _player.seek(Duration(seconds: seconds.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              String title = musicList[index]['title']!;
              String path = musicList[index]['path']!;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(
                      _currentTrack == path
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      size: 32,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      if (_currentTrack == path) {
                        pauseMusic();
                      } else {
                        playMusic(path);
                      }
                    },
                  ),
                  title: Text(title),
                  trailing: IconButton(
                    icon: Icon(
                      _currentTrack == path
                          ? (isPaused ? Icons.play_arrow : Icons.pause_circle)
                          : Icons.play_arrow,
                      color: Colors.green,
                    ),
                    onPressed: _currentTrack == path
                        ? (isPaused ? resumeMusic : pauseMusic)
                        : () => {},
                  ),
                ),
              );
            },
          ),
        ),

        // Progress bar
        if (_currentTrack != null) ...[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Slider(
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) {
                    seekToPosition(value);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatDuration(_position)),
                    Text(formatDuration(_duration)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
