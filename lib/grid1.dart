import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'grid2.dart';

class FlashingIconsGrid1 extends StatefulWidget {
  @override
  _FlashingIconsGridState createState() => _FlashingIconsGridState();
}

class _FlashingIconsGridState extends State<FlashingIconsGrid1> {
  List<String> images = [
    'assets/icons/gold/1.png',
    'assets/icons/white/b.png',
    'assets/icons/white/c.png',
    'assets/icons/white/d.png',
    'assets/icons/white/e.png',
    'assets/icons/white/f.png',
    'assets/icons/white/g.png',
  ];

  Map<int, String> cellImages = {};

  Random random = Random();
  Timer? _randomizeTimer;
  Timer? _showOverlayTimer;
  Timer? _updateTimeTimer;

  bool _isOverlayVisible = false;
  int _secondsElapsed = 0;
  String _timeImage = 'assets/images/30.png';

  @override
  void initState() {
    super.initState();
    _startRandomizeTimer();
    _startShowOverlayTimer();
    _startUpdateTimeTimer();
  }

  @override
  void dispose() {
    _stopRandomizeTimer();
    _stopShowOverlayTimer();
    _stopUpdateTimeTimer();
    super.dispose();
  }

  void _startRandomizeTimer() {
    _randomizeTimer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      if (!_isOverlayVisible) {
        setState(() {
          cellImages = _randomizeImages();
        });
      }
    });
  }

  void _stopRandomizeTimer() {
    _randomizeTimer?.cancel();
  }

  void _startShowOverlayTimer() {
    _showOverlayTimer = Timer(Duration(seconds: 15), () {
      if (!_isOverlayVisible) {
        setState(() {
          _timeImage = 'assets/images/0.png';
        });
        _showOverlay();
      }
    });
  }

  void _stopShowOverlayTimer() {
    _showOverlayTimer?.cancel();
  }

  void _startUpdateTimeTimer() {
    _updateTimeTimer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        if (!_isOverlayVisible) {
          _secondsElapsed += 3;
          if (_secondsElapsed == 3)
            _timeImage = 'assets/images/24.png';
          else if (_secondsElapsed == 6)
            _timeImage = 'assets/images/18.png';
          else if (_secondsElapsed == 9)
            _timeImage = 'assets/images/12.png';
          else if (_secondsElapsed == 12)
            _timeImage = 'assets/images/6.png';
          else if (_secondsElapsed == 15) _timeImage = 'assets/images/0.png';
        }
      });
    });
  }

  void _stopUpdateTimeTimer() {
    _updateTimeTimer?.cancel();
  }

  void _showOverlay() {
    setState(() {
      _isOverlayVisible = true;
      _stopRandomizeTimer();
      _stopUpdateTimeTimer();
    });
  }

  void _hideOverlay() {
    setState(() {
      _isOverlayVisible = false;
      _startRandomizeTimer();
      _startUpdateTimeTimer();
      _secondsElapsed = 0;
    });
  }

  Map<int, String> _randomizeImages() {
    Map<int, String> newImages = {};
    List<int> imageIndexes = List.generate(images.length, (index) => index);
    imageIndexes.shuffle();

    for (int i = 0; i < 6; i++) {
      int cellIndex = random.nextInt(12);
      while (newImages.containsKey(cellIndex)) {
        cellIndex = random.nextInt(12);
      }
      newImages[cellIndex] = images[imageIndexes[i]];
    }

    return newImages;
  }

  @override
  Widget build(BuildContext context) {
    final cellAspectRatio = 1.0;
    final cellCount = 12;

    final crossAxisCount = 4;
    final padding = 50.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final cellSize =
        (screenWidth - padding * (crossAxisCount + 1)) / crossAxisCount / 1.5;
    final aspectRatio = 1.0;
    final imageHeight = cellSize / 2;
    final gridView = GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: cellCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: cellAspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        String? image = cellImages[index];
        return InkWell(
          onTap: () {
            if (image == 'assets/icons/gold/1.png') {
              setState(() {
                _isOverlayVisible = true;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFC5A54A), width: 2),
            ),
            child: Center(
              child: image == null
                  ? Container(color: Colors.transparent)
                  : Image.asset(
                      image,
                      height: imageHeight,
                    ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_plain.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/topBar.png',
            ),
          ),
          // Positioned(
          //   child: Image.asset(
          //     'assets/images/grid.png',
          //     width: 655,
          //     height: 655,
          //   ),
          //   left: (screenWidth / 2) - 327.5,
          //   top: (screenHeight / 2) - 289,
          // ),
          Positioned(
            child: Column(
              children: [
                Image.asset(
                  _timeImage,
                  width: 150,
                  height: 150,
                ),
                Container(
                  child: Text(
                    'TIME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'CustomFont',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                //   return Text(
                //     '${_secondsElapsed ~/ 60}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 24,
                //       fontFamily: 'CustomFont',
                //       fontWeight: FontWeight.bold,
                //     ),
                //   );
                // }),
              ],
            ),
            left: 50,
            top: 150,
          ),
          Positioned(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/level1.png',
                  width: 150,
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'LEVEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'CustomFont',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            right: 50,
            top: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 0),
            // Added padding to top and bottom only
            child: Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: gridView,
              ),
            ),
          ),
          if (_isOverlayVisible)
            GestureDetector(
              onTap: () {
                // Do something when the overlay is tapped
              },
              child: GestureDetector(
                onTap: () {
                  // Navigate to the next page when the icon is tapped
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlashingIconsGrid2()));
                },
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Icon 1.png',
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Select Scotch \nMalts',
                            style: TextStyle(
                              color: Color.fromRGBO(247, 222, 132, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(134, 99, 66, 1),
                              Color.fromRGBO(247, 222, 132, 1),
                              Color.fromRGBO(247, 222, 132, 1),
                              Color.fromRGBO(247, 222, 132, 1),
                              Color.fromRGBO(134, 99, 66, 1),
                            ],
                            stops: [
                              0.01,
                              0.2,
                              0.5,
                              0.7,
                              0.95,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            transform: GradientRotation(170 * (pi / 180)),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
