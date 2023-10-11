import 'dart:ui';

class Courses {
  final String title, description, iconSrc;
  final Color bgColor;
  const Courses({
    required this.title,
    this.description = "Build and animate an IOS app from scratch",
    this.iconSrc = "assets/icons/ios.svg",
    this.bgColor = const Color(0xff7553f6),
  });
}

List<Courses> courses = [
  Courses(title: "Animations in SwiftUI"),
  Courses(
    title: "Animations in Flutter",
    iconSrc: "assets/icons/code.svg",
    bgColor: const Color(0xff80a4ff),
  ),
];

List<Courses> recentCourses = [
  Courses(title: "State Machine"),
  Courses(
      title: "Animated Menu",
      bgColor: const Color(0xff9cc5ff),
      iconSrc: "assets/icons/code.svg"),
  Courses(title: "Flutter with Rive"),
  Courses(
      title: "Animated Menu",
      bgColor: const Color(0xff9cc5ff),
      iconSrc: "assets/icons/code.svg"),
];
