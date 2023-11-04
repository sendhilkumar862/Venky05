import 'package:flutter/material.dart';
import '../../selection.dart';
import 'types.dart';

abstract class ChoiceGroup {
  static const EdgeInsets defaultListPadding = EdgeInsets.symmetric(
    vertical: 20,
  );

  static const EdgeInsets defaultHeaderPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
  );

  /// Create default group list builder
  static ChoiceGroupBuilder createList({
    bool shrinkWrap = true,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding = defaultListPadding,
  }) {
    return (itemBuilder, int itemCount) {
      return ListView.builder(
        primary: false,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int i) => itemBuilder(i),
      );
    };
  }

  /// Create default group item builder
  static ChoiceGroupItemBuilder createItem() {
    return (Widget header, Widget choices) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[header, choices],
      );
    };
  }

  /// Create default group header builder
  static ChoiceGroupHeaderBuilder createHeader({
    bool? dense,
    TextStyle? textStyle,
    EdgeInsetsGeometry? contentPadding = defaultHeaderPadding,
    bool hideCounter = false,
  }) {
    return (String name, List<int> indices) {
      return Builder(
        builder: (BuildContext context) {
          final TextStyle? effectiveTextStyle =
              textStyle ?? Theme.of(context).textTheme.titleSmall;
          return ListTile(
            dense: dense,
            title: Text(name),
            trailing: !hideCounter ? Text(indices.length.toString()) : null,
            titleTextStyle: effectiveTextStyle,
            leadingAndTrailingTextStyle: effectiveTextStyle,
            contentPadding: contentPadding,
          );
        },
      );
    };
  }

  /// Create selectable group header builder
  static ChoiceGroupHeaderBuilder<T> createSelectableHeader<T>({
    bool? dense,
    TextStyle? textStyle,
    EdgeInsetsGeometry? contentPadding = defaultHeaderPadding,
    bool hideCounter = false,
    required T Function(int i) valueResolver,
  }) {
    return (String name, List<int> indices) {
      return Builder(
        builder: (BuildContext context) {
          final TextStyle? effectiveTextStyle =
              textStyle ?? Theme.of(context).textTheme.titleSmall;
          final List<T> values = indices.map(valueResolver).whereType<T>().toList();
          return ChoiceConsumer<T>(builder: (ChoiceController<T> state, _) {
            return ListTile(
              dense: dense,
              title: Row(
                children: <Widget>[
                  Text(name),
                  if (!hideCounter) const Text(' - '),
                  if (!hideCounter) Text(indices.length.toString()),
                ],
              ),
              trailing: Checkbox(
                value: state.selectedMany(values),
                onChanged: state.onSelectedMany(values),
                tristate: true,
              ),
              titleTextStyle: effectiveTextStyle,
              leadingAndTrailingTextStyle: effectiveTextStyle,
              contentPadding: contentPadding,
              onTap: () {
                state.selectMany(values);
              },
            );
          });
        },
      );
    };
  }
}

abstract class ChoiceGroupSort {
  /// Function to sort the group alphabetically by name in ascending order
  static const int Function(String a, String b) asc = _asc;
  static int _asc(String a, String b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  }

  /// Function to sort the group alphabetically by name in descending order
  static const int Function(String a, String b) desc = _desc;
  static int _desc(String a, String b) {
    return b.toLowerCase().compareTo(a.toLowerCase());
  }
}
