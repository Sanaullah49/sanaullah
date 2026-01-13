import 'package:flutter/material.dart';

import '../../../core/theme/theme_provider.dart';
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
  final _projectTypeCtrl = TextEditingController();
  final _budgetCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _projectTypeCtrl.dispose();
    _budgetCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() => _isSubmitting = true);

    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final projectType = _projectTypeCtrl.text.trim();
    final budget = _budgetCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    final subject = 'New Project Inquiry from $name';
    final body =
        '''
Name: $name
Email: $email
Project Type: ${projectType.isEmpty ? 'Not specified' : projectType}
Budget: ${budget.isEmpty ? 'Not specified' : budget}

Message:
$message
''';

    try {
      await UrlLauncherUtils.launchEmail(subject: subject, body: body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening your email client. Please review and send.'),
          ),
        );
      }

      _formKey.currentState?.reset();
      _projectTypeCtrl.clear();
      _budgetCtrl.clear();
      _messageCtrl.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open email client. Please contact directly.',
            ),
          ),
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
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell me about your project',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'No spam. No obligation. Just a clear, honest response on how I can help.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _TextField(
                  controller: _nameCtrl,
                  label: 'Your Name',
                  hint: 'John Doe',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _TextField(
                  controller: _emailCtrl,
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Please enter your email';
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(v)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _TextField(
                  controller: _projectTypeCtrl,
                  label: 'Project Type',
                  hint: 'e.g. Fintech app, Healthcare app',
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _TextField(
                  controller: _budgetCtrl,
                  label: 'Budget (optional)',
                  hint: '\$2000 - \$5000',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _TextField(
            controller: _messageCtrl,
            label: 'Project Details',
            hint:
                'Share a quick overview: goals, deadlines, must-have features...',
            maxLines: 6,
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please describe your project';
              }
              if (value.trim().length < 20) {
                return 'Give a bit more detail so I can respond properly';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Send Message',
                  icon: Icons.send_rounded,
                  isLoading: _isSubmitting,
                  onPressed: _isSubmitting ? null : _submit,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'I typically reply within 12–24 hours.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _TextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final effectiveKeyboardType =
        (textInputAction == TextInputAction.newline && maxLines > 1)
        ? TextInputType.multiline
        : keyboardType;

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: effectiveKeyboardType,
      validator: validator,
      style: context.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
