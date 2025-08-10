import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

final _tiktok_color = 0xFF141518;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter tiktok',
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarTiktok(),
    );
  }
}

class BottomNavigationBarTiktok extends StatefulWidget {
  const BottomNavigationBarTiktok({super.key});

  @override
  State<BottomNavigationBarTiktok> createState() =>
      _BottomNavigationBarTiktokState();
}

class _BottomNavigationBarTiktokState extends State<BottomNavigationBarTiktok> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tiktok-add.png', height: 30),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_outlined),
            label: 'Comment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(_tiktok_color),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<Map> tiktokItems = [
    {"video": "assets/videos/video-1.mp4"},
    {"video": "assets/videos/video-2.mp4"},
    {"video": "assets/videos/video-3.mp4"},
    {"video": "assets/videos/video-4.mp4"},
    {"video": "assets/videos/video-5.mp4"},
    {"video": "assets/videos/video-6.mp4"},
    {"video": "assets/videos/video-7.mp4"},
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: double.infinity,
        scrollDirection: Axis.vertical,
        viewportFraction: 1.0,
      ),
      items: tiktokItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: Color(_tiktok_color),
              child: Stack(
                children: [
                  VideoWidget(videoUrl: item['video']),
                  PostContent(),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState(this.videoUrl);
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  final String videoUrl;
  bool _showPauseIcon = false;

  _VideoWidgetState(this.videoUrl);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  void _tooglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showPauseIcon = true;
      } else {
        _controller.play();
        _showPauseIcon = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tooglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          if (_showPauseIcon)
            Icon(
              Icons.pause_circle_filled,
              size: 80,
              color: Colors.white.withOpacity(0.8),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Following',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 20),
              Text(
                'For you',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@elanrif_10',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Going full send in Squaw Valley, #snow @elanrif_10 #extremesports #sendit #winter',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.music_note, color: Colors.white, size: 15),
                          SizedBox(width: 5),
                          Text(
                            'Original Sound - extremesports_96',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                'assets/images/bob-marley.png',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    SizedBox(
                      height: 60,
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white.withOpacity(0.85),
                            size: 30,
                          ),
                          Text(
                            '123.1k',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Column(
                        children: [
                          Icon(
                            Icons.message,
                            color: Colors.white.withOpacity(0.85),
                            size: 30,
                          ),
                          Text(
                            '156',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Column(
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white.withOpacity(0.85),
                            size: 30,
                          ),
                          Text(
                            '3M',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedLogo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: const DecorationImage(
            image: AssetImage('assets/images/disc-icon.png'),
          ),
        ),
        child: Image.asset('assets/images/tiktok-icon.png'),
      ),
    );
  }
}
