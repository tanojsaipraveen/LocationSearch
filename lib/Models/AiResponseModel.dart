class AiResponseModel {
  AiResponseModel({
    required this.tripDetails,
    required this.itinerary,
    required this.budgetEstimate,
  });

  final TripDetails? tripDetails;
  final List<Itinerary> itinerary;
  final BudgetEstimate? budgetEstimate;

  factory AiResponseModel.fromJson(Map<String, dynamic> json) {
    return AiResponseModel(
      tripDetails: json["trip_details"] == null
          ? null
          : TripDetails.fromJson(json["trip_details"]),
      itinerary: json["itinerary"] == null
          ? []
          : List<Itinerary>.from(
              json["itinerary"]!.map((x) => Itinerary.fromJson(x))),
      budgetEstimate: json["budget_estimate"] == null
          ? null
          : BudgetEstimate.fromJson(json["budget_estimate"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_details": tripDetails?.toJson(),
        "itinerary": itinerary.map((x) => x?.toJson()).toList(),
        "budget_estimate": budgetEstimate?.toJson(),
      };
}

class BudgetEstimate {
  BudgetEstimate({
    required this.accommodation,
    required this.mealsPerDayPerPerson,
    required this.transportation,
    required this.attractions,
    required this.miscellaneous,
    required this.totalEstimatedBudgetPerPerson,
  });

  final Accommodation? accommodation;
  final PerPerson? mealsPerDayPerPerson;
  final Miscellaneous? transportation;
  final Attractions? attractions;
  final Miscellaneous? miscellaneous;
  final PerPerson? totalEstimatedBudgetPerPerson;

  factory BudgetEstimate.fromJson(Map<String, dynamic> json) {
    return BudgetEstimate(
      accommodation: json["accommodation"] == null
          ? null
          : Accommodation.fromJson(json["accommodation"]),
      mealsPerDayPerPerson: json["meals_per_day_per_person"] == null
          ? null
          : PerPerson.fromJson(json["meals_per_day_per_person"]),
      transportation: json["transportation"] == null
          ? null
          : Miscellaneous.fromJson(json["transportation"]),
      attractions: json["attractions"] == null
          ? null
          : Attractions.fromJson(json["attractions"]),
      miscellaneous: json["miscellaneous"] == null
          ? null
          : Miscellaneous.fromJson(json["miscellaneous"]),
      totalEstimatedBudgetPerPerson:
          json["total_estimated_budget_per_person"] == null
              ? null
              : PerPerson.fromJson(json["total_estimated_budget_per_person"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "accommodation": accommodation?.toJson(),
        "meals_per_day_per_person": mealsPerDayPerPerson?.toJson(),
        "transportation": transportation?.toJson(),
        "attractions": attractions?.toJson(),
        "miscellaneous": miscellaneous?.toJson(),
        "total_estimated_budget_per_person":
            totalEstimatedBudgetPerPerson?.toJson(),
      };
}

class Accommodation {
  Accommodation({
    required this.rangePerNight,
  });

  final String? rangePerNight;

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      rangePerNight: json["range_per_night"],
    );
  }

  Map<String, dynamic> toJson() => {
        "range_per_night": rangePerNight,
      };
}

class Attractions {
  Attractions({
    required this.rangeFor5DaysPerPerson,
  });

  final String? rangeFor5DaysPerPerson;

  factory Attractions.fromJson(Map<String, dynamic> json) {
    return Attractions(
      rangeFor5DaysPerPerson: json["range_for_5_days_per_person"],
    );
  }

  Map<String, dynamic> toJson() => {
        "range_for_5_days_per_person": rangeFor5DaysPerPerson,
      };
}

class PerPerson {
  PerPerson({
    required this.range,
  });

  final String? range;

  factory PerPerson.fromJson(Map<String, dynamic> json) {
    return PerPerson(
      range: json["range"],
    );
  }

  Map<String, dynamic> toJson() => {
        "range": range,
      };
}

class Miscellaneous {
  Miscellaneous({
    required this.rangeFor5Days,
  });

  final String? rangeFor5Days;

  factory Miscellaneous.fromJson(Map<String, dynamic> json) {
    return Miscellaneous(
      rangeFor5Days: json["range_for_5_days"],
    );
  }

  Map<String, dynamic> toJson() => {
        "range_for_5_days": rangeFor5Days,
      };
}

class Itinerary {
  Itinerary({
    required this.day,
    required this.date,
    required this.placesToVisit,
  });

  final int? day;
  final String? date;
  final List<PlacesToVisit> placesToVisit;

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      day: json["day"],
      date: json["date"],
      placesToVisit: json["places_to_visit"] == null
          ? []
          : List<PlacesToVisit>.from(
              json["places_to_visit"]!.map((x) => PlacesToVisit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "date": date,
        "places_to_visit": placesToVisit.map((x) => x?.toJson()).toList(),
      };
}

class PlacesToVisit {
  PlacesToVisit({
    required this.name,
    required this.bestTimeToVisit,
    required this.description,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  final String? name;
  final String? bestTimeToVisit;
  final String? description;
  final double? rating;
  final double? latitude;
  final double? longitude;
  final String? image;

  factory PlacesToVisit.fromJson(Map<String, dynamic> json) {
    return PlacesToVisit(
      name: json["name"],
      bestTimeToVisit: json["best_time_to_visit"],
      description: json["description"],
      rating: json["rating"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "best_time_to_visit": bestTimeToVisit,
        "description": description,
        "rating": rating,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
      };
}

class TripDetails {
  TripDetails({
    required this.duration,
    required this.startDate,
  });

  final String? duration;
  final String? startDate;

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      duration: json["duration"],
      startDate: json["start_date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "start_date": startDate,
      };
}
