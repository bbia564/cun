import 'dart:convert';

class Plan {
  int? id;
  String? title;
  double? targetAmount;
  String? image;
  List<Record>? record;

  Plan({this.id, this.title, this.targetAmount, this.image, this.record});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    targetAmount = json['targetAmount'];
    image = json['image'];
    if (json['record'] != null) {
      record = <Record>[];
      if (json['record'] is String) {
        var result = jsonDecode(json['record']);
        if (result != null) {
          result.forEach((v) {
            record!.add(new Record.fromJson(v));
          });
        }
      } else {
        json['record'].forEach((v) {
          record!.add(new Record.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['targetAmount'] = this.targetAmount;
    data['image'] = this.image;
    if (this.record != null) {
      data['record'] = this.record!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Record {
  String? time;
  String? amount;

  Record({this.time, this.amount});

  Record.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['amount'] = this.amount;
    return data;
  }
}
