List<Agent> getAgentsFromjson(List<dynamic> json) =>
    List.generate(json.length, (index) => Agent.fromJson(json[index]));

class Agent {
  int id;
  String name;
  double latitude;
  double longitude;
  double? distance;
  Region? region;
  Ward? ward;

  Agent({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.region,
    this.ward,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: json['company_name'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      distance: json.containsKey('distance') ? json['distance'] : null,
      region:
          json.containsKey('region') ? Region.fromMap(json['region']) : null,
      ward: json.containsKey('ward') ? Ward.fromMap(json['ward']) : null,
    );
  }
}

class Region {
  String? name;

  Region({
    this.name,
  });

  factory Region.fromMap(Map<String, dynamic> json) {
    return Region(
      name: json['name'],
    );
  }
}

class Ward {
  String? name;

  Ward({
    this.name,
  });

  factory Ward.fromMap(Map<String, dynamic> json) {
    return Ward(
      name: json['name'],
    );
  }
}
