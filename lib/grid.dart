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
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      setState(() {
        cellIcons = _randomizeIcons();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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

  Color randomColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cellAspectRatio = 1.0;
    final cellCount = 12;
    final crossAxisCount = 4;
    final padding = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final cellSize = (screenWidth - padding * (crossAxisCount + 1)) / crossAxisCount;
    final aspectRatio = (cellSize * crossAxisCount + padding * (crossAxisCount + 1)) /
        (cellSize * (cellCount / crossAxisCount).ceil() + padding * ((cellCount / crossAxisCount).ceil() + 1));
    final iconSize = cellSize / 2; // set icon size to half of the cell size
    final gridView = GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: cellCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        childAspectRatio: cellAspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        return TimerBuilder.periodic(
          Duration(milliseconds: 500),
          builder: (BuildContext context) {
            IconData? icon = cellIcons[index];

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Center(
                child: icon == null
                    ? Container(color: Colors.transparent)
                    : Icon(
                  icon,
                  color: randomColor(),
                  size: iconSize,
                ),
              ),
            );
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashing Icons Grid'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: gridView,
        ),
      ),
    );
  }
}
