import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _projectCtrl = TextEditingController();
  final _budgetCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _projectCtrl.dispose();
    _budgetCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final body =
        '''
Name: ${_nameCtrl.text}
Email: ${_emailCtrl.text}
Project: ${_projectCtrl.text}
Budget: ${_budgetCtrl.text}

Message:
${_messageCtrl.text}
    ''';

    try {
      await UrlLauncherUtils.launchEmail(
        subject: 'New Project Inquiry – ${_nameCtrl.text}',
        body: body,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening email client...')),
        );
      }

      _formKey.currentState?.reset();
      _projectCtrl.clear();
      _budgetCtrl.clear();
      _messageCtrl.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open email app')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(
        context.responsive(
          mobile: isSmallMobile ? 20 : 24,
          tablet: 26,
          desktop: 28,
        ),
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(
          context.responsive(mobile: 20, tablet: 22, desktop: 24),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell me about your project',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isSmallMobile ? 20 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallMobile ? 6 : 8),
            Text(
              'No spam • No obligation • Fast & honest reply',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: isSmallMobile ? 13 : 15,
              ),
            ),
            SizedBox(
              height: context.responsive(mobile: 20, tablet: 24, desktop: 28),
            ),

            if (isMobile) ...[
              _FormField(
                controller: _nameCtrl,
                label: 'Your Name',
                hint: 'John Doe',
                validator: (v) => (v?.trim().isEmpty ?? true)
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 16),
              _FormField(
                controller: _emailCtrl,
                label: 'Email Address',
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Email required';
                  if (!v!.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: _FormField(
                      controller: _nameCtrl,
                      label: 'Your Name',
                      hint: 'John Doe',
                      validator: (v) => (v?.trim().isEmpty ?? true)
                          ? 'Please enter your name'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _FormField(
                      controller: _emailCtrl,
                      label: 'Email Address',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v?.isEmpty ?? true) return 'Email required';
                        if (!v!.contains('@')) return 'Invalid email';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            if (isMobile) ...[
              _FormField(
                controller: _projectCtrl,
                label: 'Project Type',
                hint: 'e.g. Fintech, SaaS, Healthcare',
              ),
              const SizedBox(height: 16),
              _FormField(
                controller: _budgetCtrl,
                label: 'Budget Range (optional)',
                hint: '\$5k – \$20k',
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: _FormField(
                      controller: _projectCtrl,
                      label: 'Project Type',
                      hint: 'e.g. Fintech, SaaS, Healthcare',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _FormField(
                      controller: _budgetCtrl,
                      label: 'Budget Range (optional)',
                      hint: '\$5k – \$20k',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            _FormField(
              controller: _messageCtrl,
              label: 'Project Details',
              hint: 'Share your goals, timeline, must-have features...',
              maxLines: isMobile ? 5 : 6,
              validator: (v) => (v?.trim().length ?? 0) < 20
                  ? 'Please give more detail (at least 20 characters)'
                  : null,
            ),

            SizedBox(
              height: context.responsive(mobile: 20, tablet: 24, desktop: 28),
            ),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: _isSubmitting ? 'Opening email...' : 'Send Message',
                icon: Icons.send_rounded,
                isLoading: _isSubmitting,
                onPressed: _isSubmitting ? null : _submit,
                height: context.responsive(
                  mobile: isSmallMobile ? 50 : 52,
                  tablet: 54,
                  desktop: 56,
                ),
              ),
            ),

            SizedBox(height: isSmallMobile ? 10 : 12),

            Center(
              child: Text(
                'I reply within 12–24 hours • 100% response rate',
                style: TextStyle(
                  fontSize: isSmallMobile ? 12 : 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontSize: isSmallMobile ? 14 : 15),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(fontSize: isSmallMobile ? 13 : 14),
        hintStyle: TextStyle(fontSize: isSmallMobile ? 13 : 14),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 14 : 16,
          vertical: isMobile ? 14 : 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
