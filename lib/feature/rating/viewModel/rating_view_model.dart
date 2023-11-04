import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';


part 'rating_view_model.g.dart';

class RatingViewModel = _RatingViewModelBase with _$RatingViewModel;

abstract class _RatingViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

}
