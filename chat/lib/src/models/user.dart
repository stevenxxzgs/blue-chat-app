class User {
  final String? _id;
  String? get id => _id; // ✅ 只读 getter
  String username;
  String photoUrl;
  bool active;
  DateTime lastseen;

  User({
    String? id,
    required this.username,
    required this.photoUrl,
    required this.active,
    required this.lastseen,
  }) : _id = id;

  Map<String, dynamic> toJson() => {
    if (_id != null) 'id': _id, // ✅ 仅在非空时写入
    'username': username,
    'photoUrl': photoUrl,
    'active': active,
    'lastseen': lastseen.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      photoUrl: json['photoUrl'],
      active: json['active'],
      lastseen: DateTime.parse(json['lastseen']),
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? photoUrl,
    bool? active,
    DateTime? lastseen,
  }) {
    return User(
      id: id ?? _id,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      active: active ?? this.active,
      lastseen: lastseen ?? this.lastseen,
    );
  }
}
