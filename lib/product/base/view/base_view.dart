import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class BaseView<T extends Store> extends StatefulWidget {
  const BaseView({
    super.key,
    required this.viewModel,
    required this.onPageBuilder,
    required this.onModelReady,
    this.onDispose,
  });
  final Widget Function(BuildContext context, T value) onPageBuilder;
  final T viewModel;
  final void Function(T model) onModelReady;
  final VoidCallback? onDispose;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  late T model;
  @override
  void initState() {
    model = widget.viewModel;
    widget.onModelReady(model);
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
    return Provider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: (BuildContext context, model, _) {
          return widget.onPageBuilder(context, model);
        },
      ),
    );
  }
}
