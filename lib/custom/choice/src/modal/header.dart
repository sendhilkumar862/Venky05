import 'package:flutter/material.dart';
import 'package:hessah/custom/choice/selection.dart';
import 'search.dart';

class ChoiceModalHeader extends AppBar {
  ChoiceModalHeader({
    super.key,
    super.primary = true,
    super.title,
    super.shape,
    super.elevation,
    super.backgroundColor,
    super.actionsIconTheme,
    super.iconTheme,
    super.centerTitle,
    super.automaticallyImplyLeading = true,
    super.leading,
    super.actions,
    super.titleSpacing,
  });

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    Widget? title,
    ShapeBorder? shape,
    double? elevation,
    Color? backgroundColor,
    IconThemeData? actionsIconTheme,
    IconThemeData? iconTheme,
    bool? centerTitle,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    ChoiceStateBuilder<T>? searchFieldBuilder,
    ChoiceStateBuilder<T>? searchToggleBuilder,
    List<ChoiceStateBuilder<T>>? actionsBuilder,
  }) {
    final effectiveSearchBuilder =
        searchFieldBuilder ?? ChoiceSearchField.create<T>();
    final effectiveSearchToggleBuilder =
        searchToggleBuilder ?? ChoiceSearchToggle.create<T>();
    return (state) {
      final searchable = state.searchable;
      final searching = state.search?.active ?? false;
      final searchWidget = effectiveSearchBuilder(state);
      final effectiveTitle =
          title ?? (state.title != null ? Text(state.title!) : null);
      final actions =
          actionsBuilder?.map((actionBuilder) => actionBuilder(state));
      final defaultLeading =
          searchable && searching ? ChoiceSearchToggle.defaultIconShow : null;
      return ChoiceModalHeader(
        key: key,
        shape: shape,
        elevation: elevation,
        backgroundColor: backgroundColor,
        actionsIconTheme: actionsIconTheme,
        iconTheme: iconTheme,
        centerTitle: centerTitle,
        automaticallyImplyLeading:
            automaticallyImplyLeading || (searchable && searching),
        leading: leading ?? defaultLeading,
        titleSpacing: searchable && searching ? 0 : null,
        title: searchable && searching ? searchWidget : effectiveTitle,
        actions: [
          if (searchable) effectiveSearchToggleBuilder(state),
          if (!searching) ...?actions,
        ],
      );
    };
  }
}
