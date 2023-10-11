import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/models/courses.dart';
import 'package:rive_animation/screens/home/widgets/course_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Courses",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ...courses
                      .map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CourseCard(course: course),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Recent",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            ...recentCourses.map(
              (course) => Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: SecondaryCourseCard(course: course),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class SecondaryCourseCard extends StatelessWidget {
  const SecondaryCourseCard({
    required this.course,
    super.key,
  });
  final Courses course;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xff7553f6), Color(0xFF816BD0)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 28),
                ),
                const Text("Watch Video - 15 Minutes",
                    style: TextStyle(fontSize: 16, color: Colors.white54))
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(color: Colors.white60),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}
