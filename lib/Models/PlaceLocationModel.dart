class PlaceLocationModel {
  PlaceLocationModel({
    required this.locationId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.numReviews,
    required this.timezone,
    required this.locationString,
    required this.photo,
    required this.awards,
    required this.locationSubtype,
    required this.doubleclickZone,
    required this.preferredMapEngine,
    required this.rawRanking,
    required this.rankingGeo,
    required this.rankingGeoId,
    required this.rankingPosition,
    required this.rankingDenominator,
    required this.rankingCategory,
    required this.rankingSubcategory,
    required this.subcategoryRanking,
    required this.ranking,
    required this.distance,
    required this.distanceString,
    required this.bearing,
    required this.rating,
    required this.isClosed,
    required this.isLongClosed,
    required this.rideProviders,
    required this.description,
    required this.webUrl,
    required this.writeReview,
    required this.ancestors,
    required this.category,
    required this.subcategory,
    required this.parentDisplayName,
    required this.isJfyEnabled,
    required this.nearestMetroStation,
    required this.website,
    required this.addressObj,
    required this.address,
    required this.isCandidateForContactInfoSuppression,
    required this.subtype,
  });

  final String? locationId;
  final String? name;
  final String? latitude;
  final String? longitude;
  final String? numReviews;
  final String? timezone;
  final String? locationString;
  final Photo? photo;
  final List<dynamic> awards;
  final String? locationSubtype;
  final String? doubleclickZone;
  final String? preferredMapEngine;
  final String? rawRanking;
  final String? rankingGeo;
  final String? rankingGeoId;
  final String? rankingPosition;
  final String? rankingDenominator;
  final String? rankingCategory;
  final String? rankingSubcategory;
  final String? subcategoryRanking;
  final String? ranking;
  final dynamic distance;
  final dynamic distanceString;
  final String? bearing;
  final String? rating;
  final bool? isClosed;
  final bool? isLongClosed;
  final List<String> rideProviders;
  final String? description;
  final String? webUrl;
  final String? writeReview;
  final List<Ancestor> ancestors;
  final Category? category;
  final List<Category> subcategory;
  final String? parentDisplayName;
  final bool? isJfyEnabled;
  final List<dynamic> nearestMetroStation;
  final String? website;
  final AddressObj? addressObj;
  final String? address;
  final bool? isCandidateForContactInfoSuppression;
  final List<Category> subtype;

  factory PlaceLocationModel.fromJson(Map<String, dynamic> json) {
    return PlaceLocationModel(
      locationId: json["location_id"],
      name: json["name"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      numReviews: json["num_reviews"],
      timezone: json["timezone"],
      locationString: json["location_string"],
      photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
      awards: json["awards"] == null
          ? []
          : List<dynamic>.from(json["awards"]!.map((x) => x)),
      locationSubtype: json["location_subtype"],
      doubleclickZone: json["doubleclick_zone"],
      preferredMapEngine: json["preferred_map_engine"],
      rawRanking: json["raw_ranking"],
      rankingGeo: json["ranking_geo"],
      rankingGeoId: json["ranking_geo_id"],
      rankingPosition: json["ranking_position"],
      rankingDenominator: json["ranking_denominator"],
      rankingCategory: json["ranking_category"],
      rankingSubcategory: json["ranking_subcategory"],
      subcategoryRanking: json["subcategory_ranking"],
      ranking: json["ranking"],
      distance: json["distance"],
      distanceString: json["distance_string"],
      bearing: json["bearing"],
      rating: json["rating"],
      isClosed: json["is_closed"],
      isLongClosed: json["is_long_closed"],
      rideProviders: json["ride_providers"] == null
          ? []
          : List<String>.from(json["ride_providers"]!.map((x) => x)),
      description: json["description"],
      webUrl: json["web_url"],
      writeReview: json["write_review"],
      ancestors: json["ancestors"] == null
          ? []
          : List<Ancestor>.from(
              json["ancestors"]!.map((x) => Ancestor.fromJson(x))),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      subcategory: json["subcategory"] == null
          ? []
          : List<Category>.from(
              json["subcategory"]!.map((x) => Category.fromJson(x))),
      parentDisplayName: json["parent_display_name"],
      isJfyEnabled: json["is_jfy_enabled"],
      nearestMetroStation: json["nearest_metro_station"] == null
          ? []
          : List<dynamic>.from(json["nearest_metro_station"]!.map((x) => x)),
      website: json["website"],
      addressObj: json["address_obj"] == null
          ? null
          : AddressObj.fromJson(json["address_obj"]),
      address: json["address"],
      isCandidateForContactInfoSuppression:
          json["is_candidate_for_contact_info_suppression"],
      subtype: json["subtype"] == null
          ? []
          : List<Category>.from(
              json["subtype"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "num_reviews": numReviews,
        "timezone": timezone,
        "location_string": locationString,
        "photo": photo?.toJson(),
        "awards": awards.map((x) => x).toList(),
        "location_subtype": locationSubtype,
        "doubleclick_zone": doubleclickZone,
        "preferred_map_engine": preferredMapEngine,
        "raw_ranking": rawRanking,
        "ranking_geo": rankingGeo,
        "ranking_geo_id": rankingGeoId,
        "ranking_position": rankingPosition,
        "ranking_denominator": rankingDenominator,
        "ranking_category": rankingCategory,
        "ranking_subcategory": rankingSubcategory,
        "subcategory_ranking": subcategoryRanking,
        "ranking": ranking,
        "distance": distance,
        "distance_string": distanceString,
        "bearing": bearing,
        "rating": rating,
        "is_closed": isClosed,
        "is_long_closed": isLongClosed,
        "ride_providers": rideProviders.map((x) => x).toList(),
        "description": description,
        "web_url": webUrl,
        "write_review": writeReview,
        "ancestors": ancestors.map((x) => x?.toJson()).toList(),
        "category": category?.toJson(),
        "subcategory": subcategory.map((x) => x?.toJson()).toList(),
        "parent_display_name": parentDisplayName,
        "is_jfy_enabled": isJfyEnabled,
        "nearest_metro_station": nearestMetroStation.map((x) => x).toList(),
        "website": website,
        "address_obj": addressObj?.toJson(),
        "address": address,
        "is_candidate_for_contact_info_suppression":
            isCandidateForContactInfoSuppression,
        "subtype": subtype.map((x) => x?.toJson()).toList(),
      };
}

class AddressObj {
  AddressObj({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalcode,
  });

  final String? street1;
  final dynamic street2;
  final String? city;
  final String? state;
  final String? country;
  final dynamic postalcode;

  factory AddressObj.fromJson(Map<String, dynamic> json) {
    return AddressObj(
      street1: json["street1"],
      street2: json["street2"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      postalcode: json["postalcode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "street1": street1,
        "street2": street2,
        "city": city,
        "state": state,
        "country": country,
        "postalcode": postalcode,
      };
}

class Ancestor {
  Ancestor({
    required this.subcategory,
    required this.name,
    required this.abbrv,
    required this.locationId,
  });

  final List<Category> subcategory;
  final String? name;
  final dynamic abbrv;
  final String? locationId;

  factory Ancestor.fromJson(Map<String, dynamic> json) {
    return Ancestor(
      subcategory: json["subcategory"] == null
          ? []
          : List<Category>.from(
              json["subcategory"]!.map((x) => Category.fromJson(x))),
      name: json["name"],
      abbrv: json["abbrv"],
      locationId: json["location_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "subcategory": subcategory.map((x) => x?.toJson()).toList(),
        "name": name,
        "abbrv": abbrv,
        "location_id": locationId,
      };
}

class Category {
  Category({
    required this.key,
    required this.name,
  });

  final String? key;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      key: json["key"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };
}

class Photo {
  Photo({
    required this.images,
    required this.isBlessed,
    required this.uploadedDate,
    required this.caption,
    required this.id,
    required this.helpfulVotes,
    required this.publishedDate,
    required this.user,
  });

  final Images? images;
  final bool? isBlessed;
  final String? uploadedDate;
  final String? caption;
  final String? id;
  final String? helpfulVotes;
  final String? publishedDate;
  final User? user;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      images: json["images"] == null ? null : Images.fromJson(json["images"]),
      isBlessed: json["is_blessed"],
      uploadedDate: json["uploaded_date"],
      caption: json["caption"],
      id: json["id"],
      helpfulVotes: json["helpful_votes"],
      publishedDate: json["published_date"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "images": images?.toJson(),
        "is_blessed": isBlessed,
        "uploaded_date": uploadedDate,
        "caption": caption,
        "id": id,
        "helpful_votes": helpfulVotes,
        "published_date": publishedDate,
        "user": user?.toJson(),
      };
}

class Images {
  Images({
    required this.small,
    required this.thumbnail,
    required this.original,
    required this.large,
    required this.medium,
  });

  final Large? small;
  final Large? thumbnail;
  final Large? original;
  final Large? large;
  final Large? medium;

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      small: json["small"] == null ? null : Large.fromJson(json["small"]),
      thumbnail:
          json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
      original:
          json["original"] == null ? null : Large.fromJson(json["original"]),
      large: json["large"] == null ? null : Large.fromJson(json["large"]),
      medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "small": small?.toJson(),
        "thumbnail": thumbnail?.toJson(),
        "original": original?.toJson(),
        "large": large?.toJson(),
        "medium": medium?.toJson(),
      };
}

class Large {
  Large({
    required this.width,
    required this.url,
    required this.height,
  });

  final String? width;
  final String? url;
  final String? height;

  factory Large.fromJson(Map<String, dynamic> json) {
    return Large(
      width: json["width"],
      url: json["url"],
      height: json["height"],
    );
  }

  Map<String, dynamic> toJson() => {
        "width": width,
        "url": url,
        "height": height,
      };
}

class User {
  User({
    required this.userId,
    required this.memberId,
    required this.type,
  });

  final dynamic userId;
  final String? memberId;
  final String? type;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["user_id"],
      memberId: json["member_id"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "member_id": memberId,
        "type": type,
      };
}
