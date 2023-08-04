class SearchPlayer {
  final String name;
  final String locality;
  final int age;
  final String position;
  final double utr;
  final bool onlineStatus;

  SearchPlayer({
    required this.name,
    required this.locality,
    required this.age,
    required this.position,
    required this.utr,
    required this.onlineStatus,
  });

  factory SearchPlayer.fromJson(Map<String, dynamic> json) {
    return SearchPlayer(
      name: json['name'],
      locality: json['locality'],
      age: json['age'],
      position: json['position'],
      utr: json['utr'].toDouble(),
      onlineStatus: json['online_status'],
    );
  }
}
