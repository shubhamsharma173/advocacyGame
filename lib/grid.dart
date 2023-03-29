import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class FlashingIconsGrid extends StatefulWidget {
  @override
  _FlashingIconsGridState createState() => _FlashingIconsGridState();
}

class _FlashingIconsGridState extends State<FlashingIconsGrid> {
  List<IconData> icons = [
    Icons.favorite,
    Icons.flash_on,
    Icons.thumb_up,
    Icons.star,
    Icons.home,
    Icons.wifi,
  ];

  Map<int, IconData> cellIcons = {};

  Random random = Random();
  Timer? _timer;

  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 3000), (Timer t) {
      if (!_isOverlayVisible) {
        setState(() {
          cellIcons = _randomizeIcons();
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _showOverlay() {
    setState(() {
      _isOverlayVisible = true;
      _stopTimer();
    });
  }

  void _hideOverlay() {
    setState(() {
      _isOverlayVisible = false;
      _startTimer();
    });
  }

  Map<int, IconData> _randomizeIcons() {
    Map<int, IconData> newIcons = {};
    List<int> iconIndexes = List.generate(icons.length, (index) => index);
    iconIndexes.shuffle();

    for (int i = 0; i < 6; i++) {
      int cellIndex = random.nextInt(12);
      while (newIcons.containsKey(cellIndex)) {
        cellIndex = random.nextInt(12);
      }
      newIcons[cellIndex] = icons[iconIndexes[i]];
    }

    return newIcons;
  }

  @override
  Widget build(BuildContext context) {
    final cellAspectRatio = 1.0;
    final cellCount = 12;
    final crossAxisCount = 4;
    final padding = 32.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final cellSize =
        (screenWidth - padding * (crossAxisCount + 1)) / crossAxisCount / 1.5;
    final aspectRatio = 1.0;
    final iconSize = cellSize / 3; // set icon size to half of the cell size
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
        IconData? icon = cellIcons[index];
        return InkWell(
          onTap: () {
            if (icon == Icons.star) {
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
              child: icon == null
                  ? Container(color: Colors.transparent)
                  : Icon(
                      icon,
                      color: const Color(0xFFC5A54A),
                      size: iconSize,
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
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 0), // Added padding to top and bottom only
            child: Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: gridView,
              ),
            ),
          ),
          if (_isOverlayVisible)
            GestureDetector(
              onTap: _hideOverlay,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }
}
