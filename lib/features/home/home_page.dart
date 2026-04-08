import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanaullah/features/home/sections/hero_section.dart';

import '../../router/scroll_to_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/open_source_highlights_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with ScrollToSectionMixin {
  late final GlobalKey heroKey;
  late final GlobalKey aboutKey;
  late final GlobalKey skillsKey;
  late final GlobalKey projectsKey;
  late final GlobalKey openSourceKey;
  late final GlobalKey experienceKey;
  late final GlobalKey contactKey;

  @override
  void initState() {
    super.initState();
    heroKey = registerSection('hero');
    aboutKey = registerSection('about');
    skillsKey = registerSection('skills');
    projectsKey = registerSection('projects');
    openSourceKey = registerSection('open-source');
    experienceKey = registerSection('experience');
    contactKey = registerSection('contact');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroSection(key: heroKey),
        AboutSection(key: aboutKey),
        SkillsSection(key: skillsKey),
        ProjectsSection(key: projectsKey),
        OpenSourceHighlightsSection(key: openSourceKey),
        ExperienceSection(key: experienceKey),
        ContactSection(key: contactKey),
      ],
    );
  }
}
