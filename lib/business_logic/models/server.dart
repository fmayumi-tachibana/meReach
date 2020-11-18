class Server {
  final String id;
  final String name;
  final String url;
  String status;
  String lastUpdate;

  Server({
    this.id,
    this.name,
    this.url,
    this.status,
    this.lastUpdate,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id:  json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
      lastUpdate: json['lastUpdate'],
    );
  }
}
