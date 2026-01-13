import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;
  final String description;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
    required this.description,
  });
}

class SkillProficiency {
  final String name;
  final int percentage;
  final Color color;

  const SkillProficiency({
    required this.name,
    required this.percentage,
    required this.color,
  });
}

class TechItem {
  final String name;
  final String? iconAsset;
  final IconData? icon;
  final Color color;
  final String? url;
  final TechCategory category;

  const TechItem({
    required this.name,
    this.iconAsset,
    this.icon,
    required this.color,
    this.url,
    required this.category,
  });
}

enum TechCategory {
  language,
  framework,
  stateManagement,
  database,
  backend,
  tools,
  design,
  platform,
}

class TechStackData {
  static const List<TechItem> allTechnologies = [
    TechItem(
      name: 'Flutter',
      icon: Icons.flutter_dash,
      color: Color(0xFF02569B),
      category: TechCategory.framework,
    ),
    TechItem(
      name: 'Dart',
      icon: Icons.code,
      color: Color(0xFF0175C2),
      category: TechCategory.language,
    ),
    TechItem(
      name: 'Android',
      icon: Icons.android,
      color: Color(0xFF3DDC84),
      category: TechCategory.platform,
    ),
    TechItem(
      name: 'iOS',
      icon: Icons.apple,
      color: Color(0xFF000000),
      category: TechCategory.platform,
    ),
    TechItem(
      name: 'Java',
      icon: Icons.coffee,
      color: Color(0xFFB07219),
      category: TechCategory.language,
    ),
    TechItem(
      name: 'Kotlin',
      icon: Icons.code,
      color: Color(0xFF7F52FF),
      category: TechCategory.language,
    ),

    TechItem(
      name: 'Provider',
      icon: Icons.share,
      color: Color(0xFF5C6BC0),
      category: TechCategory.stateManagement,
    ),
    TechItem(
      name: 'Bloc',
      icon: Icons.layers,
      color: Color(0xFF00B0FF),
      category: TechCategory.stateManagement,
    ),
    TechItem(
      name: 'GetX',
      icon: Icons.flash_on,
      color: Color(0xFF8E24AA),
      category: TechCategory.stateManagement,
    ),
    TechItem(
      name: 'Riverpod',
      icon: Icons.water_drop,
      color: Color(0xFF00838F),
      category: TechCategory.stateManagement,
    ),

    TechItem(
      name: 'Firebase',
      icon: Icons.local_fire_department,
      color: Color(0xFFFFCA28),
      category: TechCategory.backend,
    ),
    TechItem(
      name: 'REST API',
      icon: Icons.api,
      color: Color(0xFF009688),
      category: TechCategory.backend,
    ),
    TechItem(
      name: 'SQLite',
      icon: Icons.storage,
      color: Color(0xFF003B57),
      category: TechCategory.database,
    ),
    TechItem(
      name: 'Hive',
      icon: Icons.hive,
      color: Color(0xFFFFEB3B),
      category: TechCategory.database,
    ),
    TechItem(
      name: 'Isar',
      icon: Icons.data_object,
      color: Color(0xFF7C4DFF),
      category: TechCategory.database,
    ),

    TechItem(
      name: 'Git',
      icon: Icons.merge_type,
      color: Color(0xFFF05032),
      category: TechCategory.tools,
    ),
    TechItem(
      name: 'GitHub',
      icon: Icons.code,
      color: Color(0xFF181717),
      category: TechCategory.tools,
    ),
    TechItem(
      name: 'VS Code',
      icon: Icons.code,
      color: Color(0xFF007ACC),
      category: TechCategory.tools,
    ),
    TechItem(
      name: 'Android Studio',
      icon: Icons.android,
      color: Color(0xFF3DDC84),
      category: TechCategory.tools,
    ),
    TechItem(
      name: 'Xcode',
      icon: Icons.apple,
      color: Color(0xFF147EFB),
      category: TechCategory.tools,
    ),
    TechItem(
      name: 'Postman',
      icon: Icons.send,
      color: Color(0xFFFF6C37),
      category: TechCategory.tools,
    ),

    TechItem(
      name: 'Figma',
      icon: Icons.design_services,
      color: Color(0xFFA259FF),
      category: TechCategory.design,
    ),
  ];

  static List<TechItem> getByCategory(TechCategory category) {
    return allTechnologies.where((t) => t.category == category).toList();
  }
}
