class QestionVedioModel {
  String? videoName;
  String? videoUrl;
  List<AudiosUrl>? audiosUrl;

  QestionVedioModel({this.videoName, this.videoUrl, this.audiosUrl});

  QestionVedioModel.fromJson(Map<String, dynamic> json) {
    videoName = json['videoName'];
    videoUrl = json['videoUrl'];
    if (json['audiosUrl'] != null) {
      audiosUrl = <AudiosUrl>[];
      json['audiosUrl'].forEach((v) {
        audiosUrl!.add(new AudiosUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoName'] = videoName;
    data['videoUrl'] = videoUrl;
    if (audiosUrl != null) {
      data['audiosUrl'] = audiosUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AudiosUrl {
  String? question1;
  String? question2;
  String? question3;
  String? wrong1;
  String? wrong2;
  String? wrong3;

  AudiosUrl(
      {this.question1,
      this.question2,
      this.question3,
      this.wrong1,
      this.wrong2,
      this.wrong3});

  AudiosUrl.fromJson(Map<String, dynamic> json) {
    question1 = json['question1'];
    question2 = json['question2'];
    question3 = json['question3'];
    wrong1 = json['wrong1'];
    wrong2 = json['wrong2'];
    wrong3 = json['wrong3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question1'] = question1;
    data['question2'] = question2;
    data['question3'] = question3;
    data['wrong1'] = wrong1;
    data['wrong2'] = wrong2;
    data['wrong3'] = wrong3;
    return data;
  }
}