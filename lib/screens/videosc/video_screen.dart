import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubes/sharePref/user_session.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const VideoScreen());
}

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String videoURL;
  late YoutubePlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getVideoLink();
  }

  Future<void> getVideoLink() async {
    String? temp = await UserSession.getLinkVideo();
    setState(() {
      videoURL = temp ?? 'https://www.youtube.com/watch?v=YMx8Bbev6T4';
    });
    initializeController();
  }

  void initializeController() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
          }
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: YoutubePlayer(
                controller: _controller,
              ),
            );
          }
        },
      ),
    );
  }
}
