class ImageConstants {
  ImageConstants._init();

  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get logo => toPng("furkan");

  String toPng(String name) => "assets/image/$name.png";
  static const String iconPath = 'assets/icons/';
  static const String saveIcon = '${iconPath}save_icon.svg';
}
