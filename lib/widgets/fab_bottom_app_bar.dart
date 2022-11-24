import 'dart:math';

import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatelessWidget {
  FABBottomAppBar({
    required this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  final List<FABBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  _updateIndex(int index) {
    onTabSelected(index);
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = selectedIndex == index ? selectedColor : this.color;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(item.iconData, color: color, size: iconSize),
              onPressed: selectedIndex != index ? () => onPressed(index) : null,
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(this.items.length, (int index) {
      return _buildTabItem(
        item: this.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    return BottomAppBar(
      shape: notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: backgroundColor,
    );
  }
}

class MyFloatingActionButtonLocation extends FloatingActionButtonLocation {
  MyFloatingActionButtonLocation({required this.itemIndex});
  final int itemIndex;
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double itemWidth = scaffoldGeometry.scaffoldSize.width / 5;
    double horizontalOffset = itemWidth * itemIndex +
        (itemWidth - scaffoldGeometry.floatingActionButtonSize.width) / 2;
    double verticalOffset = scaffoldGeometry.contentBottom -
        scaffoldGeometry.floatingActionButtonSize.height * 0.3 +
        scaffoldGeometry.minInsets.bottom;
    return Offset(horizontalOffset, verticalOffset);
  }
}

class MyFloatingActionButtonAnimator extends FloatingActionButtonAnimator {
  static const double _animationDuration = 0.5;

  double parametricBlend(double t) {
    double sqt = t * t;
    return sqt / (2.0 * (sqt - t) + 1.0);
  }

  @override
  Offset getOffset({required Offset begin, required Offset end, required double progress}) {
    double scaledProgress = min(progress / _animationDuration, 1.0);
    double easedProgress = parametricBlend(scaledProgress);
    return Tween<Offset>(begin: begin, end: end).transform(easedProgress);
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
