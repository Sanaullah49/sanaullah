import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_urls.dart';

class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  static Future<void> launchURLInNewTab(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalNonBrowserApplication,
        webOnlyWindowName: '_blank',
      );
    }
  }

  static Future<void> launchEmail({
    String email = AppUrls.email,
    String? subject,
    String? body,
  }) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email.replaceFirst('mailto:', ''),
      query: _encodeQueryParameters({
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  static Future<void> launchPhone(String phone) async {
    final phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  static Future<void> launchWhatsApp({
    String url = AppUrls.whatsapp,
    String? message,
  }) async {
    String whatsappUrl = url;
    if (message != null) {
      whatsappUrl = '$url?text=${Uri.encodeComponent(message)}';
    }
    await launchURL(whatsappUrl);
  }

  static Future<void> openGitHub() async {
    await launchURL(AppUrls.github);
  }

  static Future<void> openLinkedIn() async {
    await launchURL(AppUrls.linkedin);
  }

  static Future<void> openTwitter() async {
    await launchURL(AppUrls.twitter);
  }

  static Future<void> openBuyMeACoffee() async {
    await launchURL(AppUrls.buyMeACoffee);
  }

  static Future<void> downloadResume() async {
    await launchURL(AppUrls.resumeUrl);
  }

  static Future<void> openCalendly() async {
    await launchURL(AppUrls.calendly);
  }

  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
