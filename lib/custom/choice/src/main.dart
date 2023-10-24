import 'package:flutter/widgets.dart';
import 'package:hessah/custom/choice/inline.dart';
import 'package:hessah/custom/choice/prompt.dart';
import 'package:hessah/custom/choice/selection.dart';

/// Provide easy way to build inline, prompted,
/// or custom choice widget with single or multiple selection
class Choice<T> extends StatelessWidget {
  /// Create a choice controller to build custom single or multiple selection widget
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.multiple}
  ///
  /// A [StatefulWidget] that illustrates use of an [Choice] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineWrapped extends StatefulWidget {
  ///   const InlineWrapped({super.key});
  ///
  ///   @override
  ///   State<InlineWrapped> createState() => _InlineWrappedState();
  /// }
  ///
  /// class _InlineWrappedState extends State<InlineWrapped> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///   ];
  ///
  ///   List<String> selectedValue = [];
  ///
  ///   void setSelectedValue(List<String> value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Choice<String>(
  ///       multiple: true,
  ///       clearable: true,
  ///       value: selectedValue,
  ///       onChanged: setSelectedValue,
  ///       builder: (state, child) {
  ///         return Wrap(
  ///           children: List<Widget>.generate(
  ///             choices.length,
  ///             (i) => ChoiceChip(
  ///               selected: state.selected(choices[i]),
  ///               onSelected: state.onSelected(choices[i]),
  ///               label: Text(choices[i]),
  ///             ),
  ///           ),
  ///         );
  ///       },
  ///     );
  ///   }
  /// }
  /// ```
  Choice({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required ChoiceBuilder<T> builder,
    Widget? child,
  }) : child = ChoiceProvider<T>.builder(
          controller: ChoiceController<T>(
            title: title,
            multiple: multiple,
            clearable: clearable,
            confirmation: confirmation,
            value: value,
            onChanged: onChanged,
          ),
          builder: builder,
          child: child,
        );

  /// Create inline choice widget with single or multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.multiple}
  ///
  /// {@macro choice.params.list}
  ///
  /// A [StatefulWidget] that illustrates use of an [Choice.inline] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineWrapped extends StatefulWidget {
  ///   const InlineWrapped({super.key});
  ///
  ///   @override
  ///   State<InlineWrapped> createState() => _InlineWrappedState();
  /// }
  ///
  /// class _InlineWrappedState extends State<InlineWrapped> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///   ];
  ///
  ///   String? selectedValue;
  ///
  ///   void setSelectedValue(String? value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Choice<String>.inline(
  ///       multiple: true,
  ///       clearable: true,
  ///       value: ChoiceSingle.value(selectedValue),
  ///       onChanged: ChoiceSingle.onChanged(setSelectedValue),
  ///       itemCount: choices.length,
  ///       itemBuilder: (state, i) {
  ///         return ChoiceChip(
  ///           selected: state.selected(choices[i]),
  ///           onSelected: state.onSelected(choices[i]),
  ///           label: Text(choices[i]),
  ///         );
  ///       },
  ///       listBuilder: ChoiceList.createWrapped(
  ///         spacing: 10,
  ///         runSpacing: 10,
  ///         padding: const EdgeInsets.symmetric(
  ///           horizontal: 20,
  ///           vertical: 25,
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  Choice.inline({
    super.key,
    this.value = const [],
    this.onChanged,
    this.multiple = false,
    this.clearable = false,
    bool loading = false,
    bool error = false,
    required int itemCount,
    required IndexedChoiceStateBuilder<T> itemBuilder,
    ChoiceGroupResolver? itemGroup,
    ChoiceSkipResolver<T>? itemSkip,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
    ChoiceStateBuilder<T>? placeholderBuilder,
    ChoiceStateBuilder<T>? errorBuilder,
    ChoiceStateBuilder<T>? loaderBuilder,
    ChoiceGroupSortResolver? groupSort,
    ChoiceGroupBuilder? groupBuilder,
    ChoiceGroupItemBuilder? groupItemBuilder,
    ChoiceGroupHeaderBuilder<T>? groupHeaderBuilder,
    ChoiceListBuilder? listBuilder,
  })  : title = null,
        confirmation = false,
        child = InlineChoice<T>(
          value: value,
          onChanged: onChanged,
          multiple: multiple,
          clearable: clearable,
          loading: loading,
          error: error,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          itemGroup: itemGroup,
          itemSkip: itemSkip,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          loaderBuilder: loaderBuilder,
          groupSort: groupSort,
          groupBuilder: groupBuilder,
          groupItemBuilder: groupItemBuilder,
          groupHeaderBuilder: groupHeaderBuilder,
          listBuilder: listBuilder,
        );

  /// Create prompted choice widget with single or multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.multiple}
  ///
  /// {@macro choice.params.prompt}
  ///
  /// {@macro choice.params.list}
  ///
  /// {@macro choice.params.modal}
  ///
  /// A [StatefulWidget] that illustrates use of an [Choice.prompt] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class PromptedPopupDialog extends StatefulWidget {
  ///   const PromptedPopupDialog({super.key});
  ///
  ///   @override
  ///   State<PromptedPopupDialog> createState() => _PromptedPopupDialogState();
  /// }
  ///
  /// class _PromptedPopupDialogState extends State<PromptedPopupDialog> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///     'Education',
  ///   ];
  ///   String? selectedValue;
  ///
  ///   void setSelectedValue(String? value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SizedBox(
  ///       width: 300,
  ///       child: Card(
  ///         clipBehavior: Clip.antiAlias,
  ///         child: Choice<String>.prompt(
  ///           title: 'Category',
  ///           value: selectedValue,
  ///           onChanged: setSelectedValue,
  ///           itemCount: choices.length,
  ///           itemBuilder: (state, i) {
  ///             return RadioListTile(
  ///               value: choices[i],
  ///               groupValue: state.single,
  ///               onChanged: (value) {
  ///                 state.select(choices[i]);
  ///               },
  ///               title: ChoiceText(
  ///                 choices[i],
  ///                 highlight: state.search?.value,
  ///               ),
  ///             );
  ///           },
  ///           promptDelegate: ChoicePrompt.delegatePopupDialog(
  ///             maxHeightFactor: .5,
  ///             constraints: const BoxConstraints(maxWidth: 300),
  ///           ),
  ///           anchorBuilder: ChoiceAnchor.create(inline: true),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  Choice.prompt({
    super.key,
    this.value = const [],
    this.onChanged,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    bool loading = false,
    bool error = false,
    required int itemCount,
    required IndexedChoiceStateBuilder<T> itemBuilder,
    ChoiceGroupResolver? itemGroup,
    ChoiceSkipResolver<T>? itemSkip,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
    ChoiceStateBuilder<T>? placeholderBuilder,
    ChoiceStateBuilder<T>? errorBuilder,
    ChoiceStateBuilder<T>? loaderBuilder,
    ChoiceGroupSortResolver? groupSort,
    ChoiceGroupBuilder? groupBuilder,
    ChoiceGroupItemBuilder? groupItemBuilder,
    ChoiceGroupHeaderBuilder<T>? groupHeaderBuilder,
    ChoiceListBuilder? listBuilder,
    ChoiceStateBuilder<T>? modalHeaderBuilder,
    ChoiceStateBuilder<T>? modalFooterBuilder,
    ChoiceStateBuilder<T>? modalSeparatorBuilder,
    FlexFit modalFit = FlexFit.loose,
    ChoicePromptBuilder<T>? anchorBuilder,
    ChoicePromptDelegate<T>? promptDelegate,
    bool searchable = false,
    ValueSetter<String>? onSearch,
  }) : child = PromptedChoice<T>(
          value: value,
          onChanged: onChanged,
          title: title,
          multiple: multiple,
          clearable: clearable,
          confirmation: confirmation,
          loading: loading,
          error: error,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          itemGroup: itemGroup,
          itemSkip: itemSkip,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          loaderBuilder: loaderBuilder,
          groupSort: groupSort,
          groupBuilder: groupBuilder,
          groupItemBuilder: groupItemBuilder,
          groupHeaderBuilder: groupHeaderBuilder,
          listBuilder: listBuilder,
          modalHeaderBuilder: modalHeaderBuilder,
          modalFooterBuilder: modalFooterBuilder,
          modalSeparatorBuilder: modalSeparatorBuilder,
          modalFit: modalFit,
          anchorBuilder: anchorBuilder,
          promptDelegate: promptDelegate,
          searchable: searchable,
          onSearch: onSearch,
        );

  /// {@macro choice.title}
  final String? title;

  /// {@macro choice.multiple}
  final bool multiple;

  /// {@macro choice.clearable}
  final bool clearable;

  /// {@macro choice.confirmation}
  final bool confirmation;

  /// {@macro choice.value}
  final List<T> value;

  /// {@macro choice.onChanged}
  final ValueChanged<List<T>>? onChanged;

  /// {@template child}
  /// The widget below this widget in the tree.
  /// {@endtemplate}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
