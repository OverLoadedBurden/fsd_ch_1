part of main;

class _Ch1BottomNavigationBarClipper extends CustomClipper<Path> {
  final double radius;
  final double middleTringleDepth;
  final double tringleLerp;
  const _Ch1BottomNavigationBarClipper({
    required this.radius,
    required this.middleTringleDepth,
    required this.tringleLerp,
  });
  @override
  Path getClip(Size size) {
    Radius radius = Radius.circular(this.radius);
    Path p = Path()
      ..moveTo(this.radius, 0)
      ..arcToPoint(
        Offset(0, this.radius),
        radius: radius,
        clockwise: false,
      )
      ..lineTo(0, size.height - this.radius)
      ..arcToPoint(
        Offset(this.radius, size.height),
        radius: radius,
        clockwise: false,
      )
      ..lineTo(size.width - this.radius, size.height)
      ..arcToPoint(
        Offset(size.width, size.height - this.radius),
        radius: radius,
        clockwise: false,
      )
      ..lineTo(size.width, this.radius)
      ..arcToPoint(
        Offset(size.width - this.radius, 0),
        radius: radius,
        clockwise: false,
      )
      ..lineTo((size.width + middleTringleDepth * 2) / 2, 0)
      ..lineTo(size.width / 2, middleTringleDepth * (1 - tringleLerp))
      ..lineTo((size.width - middleTringleDepth * 2) / 2, 0)
      ..lineTo(this.radius, 0);
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
