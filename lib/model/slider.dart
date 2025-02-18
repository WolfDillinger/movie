import 'dart:convert';

class SliderModel {
  String? id;
  String? img;
  SliderModel({this.id, this.img});

  SliderModel copyWith({String? id, String? img}) {
    return SliderModel(id: id ?? this.id, img: img ?? this.img);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'img': img};
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] != null ? map['id'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
