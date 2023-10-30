import 'package:flutter/widgets.dart';

/// Text widget that supports highlight
class ChoiceText extends StatelessWidget {

  /// Default constructor
  const ChoiceText(
    this.text, {
    super.key,
    this.style,
    this.highlight,
    this.highlightColor,
    this.caseSensitive = false,
  });
  /// The text data string
  final String text;

  /// The text style
  final TextStyle? style;

  /// The highlight data string
  final String? highlight;

  /// The highlight color
  final Color? highlightColor;

  /// Whether the match is case sensitive or not
  final bool caseSensitive;

  /// Default highlight color
  ///
  /// Defaults to yellow
  static const Color defaultHighlightColor = Color(0xFFFBC02D);

  @override
  Widget build(BuildContext context) {
    final String? q = highlight;
    if (q == null || q.isEmpty || text.isEmpty) {
      return Text(text, style: style);
    }

    final TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    final TextStyle textStyle = defaultTextStyle.merge(style);
    final Pattern pattern = RegExp(q, caseSensitive: caseSensitive);
    int start = 0;
    int indexOfHighlight;
    final List<TextSpan> spans = <TextSpan>[];

    do {
      indexOfHighlight = text.indexOf(pattern, start);
      if (indexOfHighlight < 0) {
        // no highlight
        final String content = text.substring(start, text.length);
        spans.add(_normalSpan(content, textStyle));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        final String highlightedText = text.substring(start, start + q.length);
        spans.add(_highlightSpan(highlightedText, textStyle));
        start += highlightedText.length;
      } else {
        // normal + highlight
        final String normalText = text.substring(start, indexOfHighlight);
        spans.add(_normalSpan(normalText, textStyle));
        start += normalText.length;
      }
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content, TextStyle style) {
    return TextSpan(
      text: content,
      style: style.copyWith(
        backgroundColor: highlightColor ?? defaultHighlightColor,
      ),
    );
  }

  TextSpan _normalSpan(String content, TextStyle style) {
    return TextSpan(text: content, style: style);
  }
}
