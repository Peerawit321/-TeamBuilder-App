import 'dart:convert';

class Member {
  final String name;
  final String img;

  Member({required this.name, required this.img});

  factory Member.fromMap(Map<String, dynamic> map) =>
      Member(name: map['name'] ?? '', img: map['img'] ?? '');

  Map<String, String> toMap() => {'name': name, 'img': img};

  static String encodeList(List<Member> items) =>
      jsonEncode(items.map((e) => e.toMap()).toList());

  static List<Member> decodeList(String src) {
    final data = jsonDecode(src);
    if (data is List) {
      return data
          .map((e) => Member.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}
