class StoryModel {
  String? storyName;
  String? storyUrl;
  String? coverPageUrl;

  StoryModel({this.storyName, this.storyUrl, this.coverPageUrl});

  StoryModel.fromJson(Map<String, dynamic> json) {
    storyName = json['storyName'];
    storyUrl = json['storyUrl'];
    coverPageUrl = json['coverPageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['storyName'] = storyName;
    data['storyUrl'] = storyUrl;
    data['coverPageUrl'] = coverPageUrl;
    return data;
  }
}