import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../router/route_names.dart';
import '../../experience/data/experience_data.dart';
import '../widgets/hero_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 980;
        final screenHeight = MediaQuery.of(context).size.height;
        final minHeight = math.max(
          screenHeight - (isMobile ? 72 : 88),
          isMobile ? 760.0 : 720.0,
        );

        return Container(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Stack(
            children: [
              const Positioned.fill(child: HeroBackground()),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 72,
                  vertical: isMobile ? 36 : 52,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: isMobile
                        ? _buildMobileLayout(context)
                        : _buildDesktopLayout(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(right: 40, top: 28),
            child: _buildHeroContent(context),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(flex: 5, child: _buildProfilePanel(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildHeroContent(context),
        const SizedBox(height: 32),
        _buildProfilePanel(context),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusBadge(),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _MetaChip(
              icon: Icons.location_on_outlined,
              label: 'Lahore, Pakistan',
            ),
            _MetaChip(icon: Icons.language_rounded, label: 'Remote-friendly'),
            _MetaChip(
              icon: Icons.flutter_dash_rounded,
              label: 'Flutter specialist',
            ),
          ],
        ),
        const SizedBox(height: 26),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'Flutter apps that feel production-ready, not templated.',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.02,
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            AppConstants.heroDescription,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.85,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 14,
          children: [
            PrimaryButton(
              text: 'View Selected Work',
              icon: Icons.arrow_outward_rounded,
              onPressed: () => context.go(RouteNames.projects),
            ),
            SecondaryButton(
              text: 'Start A Conversation',
              icon: Icons.mail_outline_rounded,
              onPressed: () => UrlLauncherUtils.launchEmail(
                subject: 'Flutter project inquiry',
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const [
            _ProofCard(value: '3+', label: 'Years building products'),
            _ProofCard(value: '25+', label: 'Apps shipped'),
            _ProofCard(value: '3', label: 'Core domains'),
            _ProofCard(value: '2', label: 'Mobile stores'),
          ],
        ),
      ],
    );
  }

  Widget _buildProfilePanel(BuildContext context) {
    final colorScheme = context.colorScheme;
    final currentRole = ExperienceData.currentPosition;
    final signals = [
      'Clean architecture without overengineering',
      'Release-ready polish and performance tuning',
      'Clear async communication and honest feedback',
    ];
    final stack = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'Native Android',
      'Play Store + App Store',
    ];

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(
          alpha: context.isDarkMode ? 0.72 : 0.9,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: context.isDarkMode ? 0.28 : 0.08,
            ),
            blurRadius: 36,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PanelEyebrow(
            label: 'Current Focus',
            icon: Icons.waves_rounded,
          ),
          const SizedBox(height: 18),
          Text(
            currentRole == null
                ? 'Shipping reliable cross-platform apps'
                : '${currentRole.company} • ${currentRole.title}',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            currentRole?.description ??
                'Helping teams ship mobile products with better structure, smoother releases, and fewer surprises.',
            style: context.textTheme.bodyLarge?.copyWith(height: 1.75),
          ),
          const SizedBox(height: 28),
          ...signals.map(
            (signal) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _SignalRow(text: signal),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stack I reach for most',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: stack
                      .map((item) => _StackChip(label: item))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(
          alpha: context.isDarkMode ? 0.52 : 0.78,
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProofCard extends StatelessWidget {
  final String value;
  final String label;

  const _ProofCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(
          alpha: context.isDarkMode ? 0.54 : 0.82,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _PanelEyebrow extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PanelEyebrow({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SignalRow extends StatelessWidget {
  final String text;

  const _SignalRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Icon(
            Icons.arrow_outward_rounded,
            size: 15,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ),
      ],
    );
  }
}

class _StackChip extends StatelessWidget {
  final String label;

  const _StackChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
