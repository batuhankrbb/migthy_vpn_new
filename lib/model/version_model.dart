class VersionKey {
  String showNoMatterWhat = "showNoMatterWhat";
  String lowestVersionShouldBe = "lowestVersionShouldBe";
  String link = "link";
  String title = "title";
  String subtitle = "subtitle";
}

VersionKey versionKey = VersionKey();

class VersionModel {
  bool showNoMatterWhat;
  String lowestVersionShouldBe;
  String link;
  String title;
  String subTitle;

  VersionModel({
    required this.showNoMatterWhat,
    required this.lowestVersionShouldBe,
    required this.link,
    required this.title,
    required this.subTitle,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      showNoMatterWhat: json[versionKey.showNoMatterWhat],
      lowestVersionShouldBe: json[versionKey.lowestVersionShouldBe],
      link: json[versionKey.link],
      title: json[versionKey.title],
      subTitle: json[versionKey.subtitle],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[versionKey.showNoMatterWhat] = showNoMatterWhat;
    data[versionKey.link] = link;
    data[versionKey.lowestVersionShouldBe] = lowestVersionShouldBe;
    data[versionKey.title] = title;
    data[versionKey.subtitle] = subTitle;
    return data;
  }

  @override
  String toString() {
    return 'VersionModel(showNoMatterWhat: $showNoMatterWhat, lowestVersionShouldBe: $lowestVersionShouldBe, link: $link, title: $title, subTitle: $subTitle)';
  }
}
