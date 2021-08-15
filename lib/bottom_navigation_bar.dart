library main;

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parallax_animation/parallax_animation.dart';
part './clipper.dart';

class Ch1BottomNavigationBarWithMainAction extends StatefulWidget {
  final IconData Function(int index) iconAt;
  final void Function(int index) onTap;
  final int iconsLength;
  final double expansionHeight;
  final VoidCallback onMainActionTapped;
  final Widget Function(int index) demoTitle;
  final Widget Function(int index) demoSubtitle;
  final double iconsSize;
  final IconData mainAction;
  final Color background;
  final Color shadowColor;
  final Color selectedColor;
  final Color? unselectedColor;
  final Color selectedBackground;
  final Color? unselectedBackground;
  final EdgeInsets mainActionPadding;
  final double mainActionMargin;
  final EdgeInsets iconsPadding;
  final EdgeInsets barMargin;
  final EdgeInsets barPadding;
  final EdgeInsets iconsMargin;
  final Duration expandingDuration;
  final Curve expandingCurve;
  final Duration collapsingDuration;
  final Curve collapsingCurve;
  final double sidesRadius;
  final double midleTringleDepth;
  final double blur;

  const Ch1BottomNavigationBarWithMainAction({
    Key? key,
    this.background = const Color.fromARGB(255, 18, 32, 47),
    this.shadowColor = Colors.blueAccent,
    this.blur = 1.0,
    required this.iconAt,
    this.expansionHeight = 150,
    required this.onTap,
    required this.onMainActionTapped,
    required this.iconsLength,
    required this.demoTitle,
    required this.demoSubtitle,
    this.barMargin = const EdgeInsets.all(8.0),
    this.barPadding =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    required this.mainAction,
    this.sidesRadius = 8,
    this.iconsMargin = const EdgeInsets.all(4.0),
    this.expandingDuration = const Duration(milliseconds: 700),
    this.iconsSize = 24,
    this.selectedColor = Colors.blue,
    this.unselectedColor,
    this.selectedBackground = Colors.lightBlue,
    this.unselectedBackground,
    this.mainActionPadding = const EdgeInsets.all(8.0),
    this.iconsPadding = const EdgeInsets.all(4.0),
    this.expandingCurve = Curves.ease,
    this.mainActionMargin = 4.0,
    double? midleTringleDepth,
    Curve? collapsingCurve,
    Duration? collapsingDuration,
  })  : assert(iconsLength % 2 == 0),
        this.collapsingDuration = collapsingDuration ?? expandingDuration,
        this.collapsingCurve = collapsingCurve ?? expandingCurve,
        this.midleTringleDepth = midleTringleDepth ?? iconsSize / 2,
        super(key: key);

  @override
  _Ch1BottomNavigationBarWithMainActionState createState() =>
      _Ch1BottomNavigationBarWithMainActionState();
}

class _Ch1BottomNavigationBarWithMainActionState
    extends State<Ch1BottomNavigationBarWithMainAction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationView;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.expandingDuration,
      reverseDuration: widget.collapsingDuration,
    );
    _animationView = CurvedAnimation(
        parent: _animationController,
        curve: widget.expandingCurve,
        reverseCurve: widget.collapsingCurve);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (_, __) => BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blur * _animationView.value,
                  sigmaY: widget.blur * _animationView.value,
                ),
                child: IconTheme(
                  data: IconTheme.of(context).copyWith(
                    size: widget.iconsSize,
                  ),
                  child: Padding(
                    padding: widget.barMargin,
                    child: PhysicalShape(
                      color: widget.background,
                      elevation: 10,
                      clipper: _Ch1BottomNavigationBarClipper(
                        radius: widget.sidesRadius,
                        tringleLerp: _animationView.value,
                        middleTringleDepth: ((widget.iconsSize +
                                    math.max(
                                        widget.mainActionPadding.horizontal,
                                        widget.mainActionPadding.vertical)) *
                                1.5 /
                                2) +
                            widget.mainActionMargin * 2,
                      ),
                      clipBehavior: Clip.none,
                      shadowColor: widget.shadowColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRect(
                            child: Align(
                              heightFactor: _animationView.value,
                              child: SizedBox(
                                height: widget.expansionHeight,
                                child: ParallaxArea(
                                  scrollController: _pageController,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemBuilder: (_, index) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ParallaxWidget(
                                          clipOverflow: false,
                                          alignment: Alignment.center,
                                          overflowWidthFactor: 2,
                                          fixedHorizontal: true,
                                          fixedVertical: true,
                                          child: widget.demoTitle(index),
                                        ),
                                        ParallaxWidget(
                                          clipOverflow: false,
                                          alignment: Alignment.center,
                                          overflowWidthFactor: 5,
                                          child: widget.demoSubtitle(index),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: widget.barPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      for (var i = 0;
                                          i < widget.iconsLength / 2;
                                          i++)
                                        _buildIconButton(i)
                                    ],
                                  ),
                                ),
                                Opacity(
                                  opacity: 0,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(widget.mainActionMargin),
                                    child: Padding(
                                      padding: widget.mainActionPadding,
                                      child: Icon(widget.mainAction),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      for (var i =
                                              (widget.iconsLength / ~2) + 1;
                                          i < widget.iconsLength / 2 - 1;
                                          i++)
                                        _buildIconButton(
                                            ((widget.iconsLength / 2) + i)
                                                    .toInt() +
                                                1)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: widget.barMargin
                  .add(widget.mainActionPadding)
                  .add(widget.iconsMargin)
                  .add(EdgeInsets.all(widget.mainActionMargin))
                  .add(widget.barPadding),
              child: FractionalTranslation(
                translation: const Offset(0, -0.5),
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      onTap: () {
                        _animationController.isCompleted
                            ? _animationController.reverse()
                            : _animationController.forward();
                      },
                      child: Padding(
                        padding: widget.mainActionPadding,
                        child: Transform.rotate(
                          angle: math.pi / -4,
                          child: Icon(widget.mainAction),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(int index) => Padding(
        padding: widget.iconsMargin,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: CircleBorder(),
          child: InkWell(
            onTap: () => widget.onTap(index),
            child: Padding(
              padding: widget.iconsPadding,
              child: Icon(widget.iconAt(index)),
            ),
          ),
        ),
      );
}
