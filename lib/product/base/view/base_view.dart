import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends ConsumerStatefulWidget {
  const BaseView({
    super.key,
    required this.viewModel,
    required this.onPageBuilder,
    required this.onModelReady,
    this.onDispose,
  });
  final Widget Function(BuildContext context, T value, WidgetRef ref) onPageBuilder;
  final T viewModel;
  final void Function(T model, WidgetRef ref) onModelReady;
  final VoidCallback? onDispose;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends ConsumerState<BaseView<T>> {
  
  late T model;
  @override
  void initState() {
    model = widget.viewModel;
    widget.onModelReady(model, ref);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, model, ref);
  }
}
