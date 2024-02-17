// To parse this JSON data, do
//
//     final locationDataModel = locationDataModelFromJson(jsonString);

import 'dart:convert';

LocationDataModel locationDataModelFromJson(String str) =>
    LocationDataModel.fromJson(json.decode(str));

String locationDataModelToJson(LocationDataModel data) =>
    json.encode(data.toJson());

class LocationDataModel {
  Geometry? geometry;
  String? type;
  Properties? properties;

  LocationDataModel({
    this.geometry,
    this.type,
    this.properties,
  });

  factory LocationDataModel.fromJson(Map<String, dynamic> json) =>
      LocationDataModel(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        type: json["type"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "type": type,
        "properties": properties?.toJson(),
      };
}

class Geometry {
  List<double>? coordinates;
  String? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class Properties {
  String? osmType;
  int? osmId;
  String? country;
  String? osmKey;
  String? countrycode;
  String? osmValue;
  String? postcode;
  String? name;
  String? county;
  String? state;
  String? type;

  Properties({
    this.osmType,
    this.osmId,
    this.country,
    this.osmKey,
    this.countrycode,
    this.osmValue,
    this.postcode,
    this.name,
    this.county,
    this.state,
    this.type,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        country: json["country"],
        osmKey: json["osm_key"],
        countrycode: json["countrycode"],
        osmValue: json["osm_value"],
        postcode: json["postcode"],
        name: json["name"],
        county: json["county"],
        state: json["state"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "osm_type": osmType,
        "osm_id": osmId,
        "country": country,
        "osm_key": osmKey,
        "countrycode": countrycode,
        "osm_value": osmValue,
        "postcode": postcode,
        "name": name,
        "county": county,
        "state": state,
        "type": type,
      };
}
