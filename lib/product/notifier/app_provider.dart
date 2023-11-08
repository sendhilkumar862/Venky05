import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../feature/pre_login/teachingInfo/viewModel/teaching_info_view_model.dart';
import '../navigation/navigation_service.dart';
import '../theme/theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    Provider<TeachingInfoViewModel>(
      create: (context) => TeachingInfoViewModel(),
    ),
    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
