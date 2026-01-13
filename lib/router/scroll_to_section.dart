import 'package:flutter/material.dart';

class ScrollToSectionService {
  static final Map<String, GlobalKey> _sectionKeys = {};
  static ScrollController? _scrollController;

  static void registerScrollController(ScrollController controller) {
    _scrollController = controller;
  }

  static void registerSection(String sectionId, GlobalKey key) {
    _sectionKeys[sectionId] = key;
  }

  static void unregisterSection(String sectionId) {
    _sectionKeys.remove(sectionId);
  }

  static GlobalKey? getSectionKey(String sectionId) {
    return _sectionKeys[sectionId];
  }

  static Future<void> scrollToSection(
    String sectionId, {
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOutCubic,
    double offset = 0,
  }) async {
    final key = _sectionKeys[sectionId];
    if (key == null || key.currentContext == null) {
      debugPrint('Section not found: $sectionId');
      return;
    }

    final context = key.currentContext!;

    await Scrollable.ensureVisible(
      context,
      duration: duration,
      curve: curve,
      alignment: 0.0,
    );
  }

  static Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (_scrollController == null || !_scrollController!.hasClients) return;

    await _scrollController!.animateTo(0, duration: duration, curve: curve);
  }

  static Future<void> scrollToBottom({
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (_scrollController == null || !_scrollController!.hasClients) return;

    await _scrollController!.animateTo(
      _scrollController!.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  static double get currentScrollPosition {
    if (_scrollController == null || !_scrollController!.hasClients) return 0;
    return _scrollController!.offset;
  }

  static bool get isAtTop {
    if (_scrollController == null || !_scrollController!.hasClients) {
      return true;
    }
    return _scrollController!.offset <= 0;
  }

  static void clearAll() {
    _sectionKeys.clear();
    _scrollController = null;
  }
}

mixin ScrollToSectionMixin<T extends StatefulWidget> on State<T> {
  final Map<String, GlobalKey> sectionKeys = {};
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    ScrollToSectionService.registerScrollController(scrollController);
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (final sectionId in sectionKeys.keys) {
      ScrollToSectionService.unregisterSection(sectionId);
    }
    super.dispose();
  }

  GlobalKey registerSection(String sectionId) {
    final key = GlobalKey();
    sectionKeys[sectionId] = key;
    ScrollToSectionService.registerSection(sectionId, key);
    return key;
  }

  Future<void> scrollToSection(String sectionId) {
    return ScrollToSectionService.scrollToSection(sectionId);
  }

  Future<void> scrollToTop() {
    return ScrollToSectionService.scrollToTop();
  }
}
