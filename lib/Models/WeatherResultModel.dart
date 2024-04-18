class WeatherResultModel {
  WeatherResultModel({
    required this.value,
  });

  final List<Value> value;

  factory WeatherResultModel.fromJson(Map<String, dynamic> json) {
    return WeatherResultModel(
      value: json["value"] == null
          ? []
          : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value.map((x) => x?.toJson()).toList(),
      };
}

class Value {
  Value({
    required this.responses,
    required this.units,
  });

  final List<Response> responses;
  final Units? units;

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      responses: json["responses"] == null
          ? []
          : List<Response>.from(
              json["responses"]!.map((x) => Response.fromJson(x))),
      units: json["units"] == null ? null : Units.fromJson(json["units"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "responses": responses.map((x) => x?.toJson()).toList(),
        "units": units?.toJson(),
      };
}

class Response {
  Response({
    required this.weather,
    required this.source,
  });

  final List<Weather> weather;
  final Source? source;

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => Weather.fromJson(x))),
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "weather": weather.map((x) => x?.toJson()).toList(),
        "source": source?.toJson(),
      };
}

class Source {
  Source({
    required this.id,
    required this.coordinates,
    required this.location,
    required this.utcOffset,
    required this.countryCode,
  });

  final String? id;
  final Coordinates? coordinates;
  final Location? location;
  final String? utcOffset;
  final String? countryCode;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"],
      coordinates: json["coordinates"] == null
          ? null
          : Coordinates.fromJson(json["coordinates"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      utcOffset: json["utcOffset"],
      countryCode: json["countryCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "coordinates": coordinates?.toJson(),
        "location": location?.toJson(),
        "utcOffset": utcOffset,
        "countryCode": countryCode,
      };
}

class Coordinates {
  Coordinates({
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json["lat"],
      lon: json["lon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Location {
  Location({
    required this.name,
    required this.stateCode,
    required this.countryName,
    required this.countryCode,
    required this.timezoneName,
    required this.timezoneOffset,
  });

  final String? name;
  final String? stateCode;
  final String? countryName;
  final String? countryCode;
  final String? timezoneName;
  final String? timezoneOffset;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["Name"],
      stateCode: json["StateCode"],
      countryName: json["CountryName"],
      countryCode: json["CountryCode"],
      timezoneName: json["TimezoneName"],
      timezoneOffset: json["TimezoneOffset"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
        "StateCode": stateCode,
        "CountryName": countryName,
        "CountryCode": countryCode,
        "TimezoneName": timezoneName,
        "TimezoneOffset": timezoneOffset,
      };
}

class Weather {
  Weather({
    required this.days,
    required this.summaries,
  });

  final List<Day> days;
  final List<Summary> summaries;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      days: json["days"] == null
          ? []
          : List<Day>.from(json["days"]!.map((x) => Day.fromJson(x))),
      summaries: json["summaries"] == null
          ? []
          : List<Summary>.from(
              json["summaries"]!.map((x) => Summary.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "days": days.map((x) => x?.toJson()).toList(),
        "summaries": summaries.map((x) => x?.toJson()).toList(),
      };
}

class Day {
  Day({
    required this.daily,
  });

  final Daily? daily;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "daily": daily?.toJson(),
      };
}

class Daily {
  Daily({
    required this.valid,
    required this.icon,
    required this.symbol,
    required this.precip,
    required this.tempHi,
    required this.tempLo,
  });

  final DateTime? valid;
  final int? icon;
  final String? symbol;
  final double? precip;
  final double? tempHi;
  final double? tempLo;

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      valid: DateTime.tryParse(json["valid"] ?? ""),
      icon: json["icon"],
      symbol: json["symbol"],
      precip: json["precip"],
      tempHi: json["tempHi"],
      tempLo: json["tempLo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "valid": valid?.toIso8601String(),
        "icon": icon,
        "symbol": symbol,
        "precip": precip,
        "tempHi": tempHi,
        "tempLo": tempLo,
      };
}

class Summary {
  Summary({
    required this.year,
    required this.month,
    required this.monthStr,
    required this.sunnyDays,
    required this.rainyOrSnowyDays,
    required this.averageHigh,
    required this.averageLow,
    required this.highestHigh,
    required this.lowestLow,
    required this.summary,
  });

  final int? year;
  final int? month;
  final String? monthStr;
  final int? sunnyDays;
  final int? rainyOrSnowyDays;
  final double? averageHigh;
  final double? averageLow;
  final double? highestHigh;
  final double? lowestLow;
  final List<String> summary;

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      year: json["year"],
      month: json["month"],
      monthStr: json["monthStr"],
      sunnyDays: json["sunnyDays"],
      rainyOrSnowyDays: json["rainyOrSnowyDays"],
      averageHigh: json["averageHigh"],
      averageLow: json["averageLow"],
      highestHigh: json["highestHigh"],
      lowestLow: json["lowestLow"],
      summary: json["summary"] == null
          ? []
          : List<String>.from(json["summary"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "monthStr": monthStr,
        "sunnyDays": sunnyDays,
        "rainyOrSnowyDays": rainyOrSnowyDays,
        "averageHigh": averageHigh,
        "averageLow": averageLow,
        "highestHigh": highestHigh,
        "lowestLow": lowestLow,
        "summary": summary.map((x) => x).toList(),
      };
}

class Units {
  Units({
    required this.system,
    required this.pressure,
    required this.temperature,
    required this.speed,
    required this.height,
    required this.distance,
    required this.time,
  });

  final String? system;
  final String? pressure;
  final String? temperature;
  final String? speed;
  final String? height;
  final String? distance;
  final String? time;

  factory Units.fromJson(Map<String, dynamic> json) {
    return Units(
      system: json["system"],
      pressure: json["pressure"],
      temperature: json["temperature"],
      speed: json["speed"],
      height: json["height"],
      distance: json["distance"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "system": system,
        "pressure": pressure,
        "temperature": temperature,
        "speed": speed,
        "height": height,
        "distance": distance,
        "time": time,
      };
}
