import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanaullah/features/home/sections/hero_section.dart';

import '../../router/scroll_to_section.dart';
import 'sections/about_section.dart';
import 'sections/blog_section.dart';
import 'sections/contact_section.dart';
import 'sections/cta_section.dart';
import 'sections/experience_section.dart';
import 'sections/open_source_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/testimonials_section.dart';

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
  late final GlobalKey experienceKey;
  late final GlobalKey openSourceKey;
  late final GlobalKey testimonialsKey;
  late final GlobalKey blogKey;
  late final GlobalKey contactKey;
  late final GlobalKey ctaKey;

  @override
  void initState() {
    super.initState();
    heroKey = registerSection('hero');
    aboutKey = registerSection('about');
    skillsKey = registerSection('skills');
    projectsKey = registerSection('projects');
    experienceKey = registerSection('experience');
    openSourceKey = registerSection('open-source');
    testimonialsKey = registerSection('testimonials');
    blogKey = registerSection('blog');
    contactKey = registerSection('contact');
    ctaKey = registerSection('cta');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroSection(key: heroKey),

        AboutSection(key: aboutKey),

        SkillsSection(key: skillsKey),

        ProjectsSection(key: projectsKey),

        ExperienceSection(key: experienceKey),

        OpenSourceSection(key: openSourceKey),

        TestimonialsSection(key: testimonialsKey),

        BlogSection(key: blogKey),

        ContactSection(key: contactKey),

        CTASection(key: ctaKey),
      ],
    );
  }
}
