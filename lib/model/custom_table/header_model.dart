class HeaderModel {
  String title;
  void Function()? onTap;
  int? flex;

  HeaderModel({
    required this.title,
    this.onTap,
    this.flex
  });
}