// ignore_for_file: non_constant_identifier_names

class PlayersListModel {
  final String name;
  final String locality;
  final int age;
  final String position;
  final double utr;
  final bool onlineStatus;

  PlayersListModel({
    required this.name,
    required this.locality,
    required this.age,
    required this.position,
    required this.utr,
    required this.onlineStatus,
  });

  factory PlayersListModel.fromJson(Map<String, dynamic> json) {
    return PlayersListModel(
      name: json['name'],
      locality: json['locality'],
      age: json['age'],
      position: json['position'],
      utr: json['utr'].toDouble(),
      onlineStatus: json['online_status'],
    );
  }
}

class PlayersListModelList {
  final String authToken;
  final List<PlayersListModel> PlayersListModels;

  PlayersListModelList({
    required this.authToken,
    required this.PlayersListModels,
  });

  factory PlayersListModelList.fromJson(Map<String, dynamic> json) {
    var PlayersListModelsList =
        List<Map<String, dynamic>>.from(json['PlayersListModels']);
    var PlayersListModels = PlayersListModelsList.map((PlayersListModelJson) =>
        PlayersListModel.fromJson(PlayersListModelJson)).toList();

    return PlayersListModelList(
      authToken: json['auth_token'],
      PlayersListModels: PlayersListModels,
    );
  }
}
