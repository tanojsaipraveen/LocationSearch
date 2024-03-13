class NearbyModel {
  NearbyModel({
    required this.data,
    required this.filters,
    required this.filtersV2,
    required this.paging,
  });

  final List<Datum> data;
  final Filters? filters;
  final FiltersV2? filtersV2;
  final Paging? paging;

  factory NearbyModel.fromJson(Map<String, dynamic> json) {
    return NearbyModel(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      filters:
          json["filters"] == null ? null : Filters.fromJson(json["filters"]),
      filtersV2: json["filters_v2"] == null
          ? null
          : FiltersV2.fromJson(json["filters_v2"]),
      paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
        "filters": filters?.toJson(),
        "filters_v2": filtersV2?.toJson(),
        "paging": paging?.toJson(),
      };
}

class Datum {
  Datum({
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
    required this.phone,
    required this.booking,
    required this.offerGroup,
    required this.animalWelfareTag,
    required this.tags,
    required this.email,
    required this.adPosition,
    required this.adSize,
    required this.detail,
    required this.pageType,
    required this.mobPtype,
    required this.openNowText,
    required this.hours,
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
  final String? distance;
  final String? distanceString;
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
  final String? phone;
  final Booking? booking;
  final OfferGroup? offerGroup;
  final AnimalWelfareTag? animalWelfareTag;
  final Tags? tags;
  final String? email;
  final String? adPosition;
  final String? adSize;
  final String? detail;
  final String? pageType;
  final String? mobPtype;
  final String? openNowText;
  final Hours? hours;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
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
      phone: json["phone"],
      booking:
          json["booking"] == null ? null : Booking.fromJson(json["booking"]),
      offerGroup: json["offer_group"] == null
          ? null
          : OfferGroup.fromJson(json["offer_group"]),
      animalWelfareTag: json["animal_welfare_tag"] == null
          ? null
          : AnimalWelfareTag.fromJson(json["animal_welfare_tag"]),
      tags: json["tags"] == null ? null : Tags.fromJson(json["tags"]),
      email: json["email"],
      adPosition: json["ad_position"],
      adSize: json["ad_size"],
      detail: json["detail"],
      pageType: json["page_type"],
      mobPtype: json["mob_ptype"],
      openNowText: json["open_now_text"],
      hours: json["hours"] == null ? null : Hours.fromJson(json["hours"]),
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
        "phone": phone,
        "booking": booking?.toJson(),
        "offer_group": offerGroup?.toJson(),
        "animal_welfare_tag": animalWelfareTag?.toJson(),
        "tags": tags?.toJson(),
        "email": email,
        "ad_position": adPosition,
        "ad_size": adSize,
        "detail": detail,
        "page_type": pageType,
        "mob_ptype": mobPtype,
        "open_now_text": openNowText,
        "hours": hours?.toJson(),
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
  final String? street2;
  final String? city;
  final String? state;
  final String? country;
  final String? postalcode;

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

class AnimalWelfareTag {
  AnimalWelfareTag({
    required this.tagText,
    required this.msgHeader,
    required this.msgBody,
    required this.learnMoreText,
    required this.educationPortalUrl,
  });

  final String? tagText;
  final String? msgHeader;
  final String? msgBody;
  final String? learnMoreText;
  final String? educationPortalUrl;

  factory AnimalWelfareTag.fromJson(Map<String, dynamic> json) {
    return AnimalWelfareTag(
      tagText: json["tag_text"],
      msgHeader: json["msg_header"],
      msgBody: json["msg_body"],
      learnMoreText: json["learn_more_text"],
      educationPortalUrl: json["education_portal_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "tag_text": tagText,
        "msg_header": msgHeader,
        "msg_body": msgBody,
        "learn_more_text": learnMoreText,
        "education_portal_url": educationPortalUrl,
      };
}

class Booking {
  Booking({
    required this.provider,
    required this.url,
  });

  final String? provider;
  final String? url;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      provider: json["provider"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "url": url,
      };
}

class Hours {
  Hours({
    required this.weekRanges,
    required this.timezone,
  });

  final List<List<WeekRange>> weekRanges;
  final String? timezone;

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      weekRanges: json["week_ranges"] == null
          ? []
          : List<List<WeekRange>>.from(json["week_ranges"]!.map((x) => x == null
              ? []
              : List<WeekRange>.from(x!.map((x) => WeekRange.fromJson(x))))),
      timezone: json["timezone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "week_ranges":
            weekRanges.map((x) => x.map((x) => x?.toJson()).toList()).toList(),
        "timezone": timezone,
      };
}

class WeekRange {
  WeekRange({
    required this.openTime,
    required this.closeTime,
  });

  final int? openTime;
  final int? closeTime;

  factory WeekRange.fromJson(Map<String, dynamic> json) {
    return WeekRange(
      openTime: json["open_time"],
      closeTime: json["close_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "open_time": openTime,
        "close_time": closeTime,
      };
}

class OfferGroup {
  OfferGroup({
    required this.lowestPrice,
    required this.offerList,
    required this.hasSeeAllUrl,
    required this.isEligibleForApList,
  });

  final String? lowestPrice;
  final List<OfferList> offerList;
  final bool? hasSeeAllUrl;
  final bool? isEligibleForApList;

  factory OfferGroup.fromJson(Map<String, dynamic> json) {
    return OfferGroup(
      lowestPrice: json["lowest_price"],
      offerList: json["offer_list"] == null
          ? []
          : List<OfferList>.from(
              json["offer_list"]!.map((x) => OfferList.fromJson(x))),
      hasSeeAllUrl: json["has_see_all_url"],
      isEligibleForApList: json["is_eligible_for_ap_list"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lowest_price": lowestPrice,
        "offer_list": offerList.map((x) => x?.toJson()).toList(),
        "has_see_all_url": hasSeeAllUrl,
        "is_eligible_for_ap_list": isEligibleForApList,
      };
}

class OfferList {
  OfferList({
    required this.url,
    required this.price,
    required this.roundedUpPrice,
    required this.offerType,
    required this.title,
    required this.productCode,
    required this.partner,
    required this.imageUrl,
    required this.description,
    required this.primaryCategory,
  });

  final String? url;
  final String? price;
  final String? roundedUpPrice;
  final String? offerType;
  final String? title;
  final String? productCode;
  final String? partner;
  final String? imageUrl;
  final dynamic description;
  final String? primaryCategory;

  factory OfferList.fromJson(Map<String, dynamic> json) {
    return OfferList(
      url: json["url"],
      price: json["price"],
      roundedUpPrice: json["rounded_up_price"],
      offerType: json["offer_type"],
      title: json["title"],
      productCode: json["product_code"],
      partner: json["partner"],
      imageUrl: json["image_url"],
      description: json["description"],
      primaryCategory: json["primary_category"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "price": price,
        "rounded_up_price": roundedUpPrice,
        "offer_type": offerType,
        "title": title,
        "product_code": productCode,
        "partner": partner,
        "image_url": imageUrl,
        "description": description,
        "primary_category": primaryCategory,
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

class Tags {
  Tags({
    required this.animalWelfareTag,
  });

  final AnimalWelfareTag? animalWelfareTag;

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      animalWelfareTag: json["animal_welfare_tag"] == null
          ? null
          : AnimalWelfareTag.fromJson(json["animal_welfare_tag"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "animal_welfare_tag": animalWelfareTag?.toJson(),
      };
}

class Filters {
  Filters({
    required this.distance,
    required this.subtype,
    required this.minRating,
    required this.rating,
    required this.subcategory,
    required this.typeaheadTag,
    required this.excludeLocations,
  });

  final Map<String, Distance> distance;
  final Map<String, Distance> subtype;
  final Map<String, Distance> minRating;
  final Rating? rating;
  final Map<String, Distance> subcategory;
  final Map<String, Distance> typeaheadTag;
  final ExcludeLocations? excludeLocations;

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      distance: Map.from(json["distance"])
          .map((k, v) => MapEntry<String, Distance>(k, Distance.fromJson(v))),
      subtype: Map.from(json["subtype"])
          .map((k, v) => MapEntry<String, Distance>(k, Distance.fromJson(v))),
      minRating: Map.from(json["min_rating"])
          .map((k, v) => MapEntry<String, Distance>(k, Distance.fromJson(v))),
      rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      subcategory: Map.from(json["subcategory"])
          .map((k, v) => MapEntry<String, Distance>(k, Distance.fromJson(v))),
      typeaheadTag: Map.from(json["typeahead_tag"])
          .map((k, v) => MapEntry<String, Distance>(k, Distance.fromJson(v))),
      excludeLocations: json["exclude_locations"] == null
          ? null
          : ExcludeLocations.fromJson(json["exclude_locations"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "distance": Map.from(distance)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "subtype": Map.from(subtype)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "min_rating": Map.from(minRating)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "rating": rating?.toJson(),
        "subcategory": Map.from(subcategory)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "typeahead_tag": Map.from(typeaheadTag)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "exclude_locations": excludeLocations?.toJson(),
      };
}

class Distance {
  Distance({
    required this.count,
    required this.label,
    required this.priority,
    required this.selected,
    required this.localeIndependentLabel,
    required this.parentId,
  });

  final String? count;
  final String? label;
  final String? priority;
  final bool? selected;
  final String? localeIndependentLabel;
  final String? parentId;

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      count: json["count"],
      label: json["label"],
      priority: json["priority"],
      selected: json["selected"],
      localeIndependentLabel: json["locale_independent_label"],
      parentId: json["parent_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "label": label,
        "priority": priority,
        "selected": selected,
        "locale_independent_label": localeIndependentLabel,
        "parent_id": parentId,
      };
}

class ExcludeLocations {
  ExcludeLocations({
    required this.filtered,
    required this.all,
  });

  final All? filtered;
  final All? all;

  factory ExcludeLocations.fromJson(Map<String, dynamic> json) {
    return ExcludeLocations(
      filtered:
          json["filtered"] == null ? null : All.fromJson(json["filtered"]),
      all: json["all"] == null ? null : All.fromJson(json["all"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "filtered": filtered?.toJson(),
        "all": all?.toJson(),
      };
}

class All {
  All({
    required this.count,
    required this.label,
  });

  final String? count;
  final String? label;

  factory All.fromJson(Map<String, dynamic> json) {
    return All(
      count: json["count"],
      label: json["label"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "label": label,
      };
}

class Rating {
  Rating({
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.all,
  });

  final Distance? the1;
  final Distance? the2;
  final Distance? the3;
  final Distance? the4;
  final Distance? the5;
  final Distance? all;

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      the1: json["1"] == null ? null : Distance.fromJson(json["1"]),
      the2: json["2"] == null ? null : Distance.fromJson(json["2"]),
      the3: json["3"] == null ? null : Distance.fromJson(json["3"]),
      the4: json["4"] == null ? null : Distance.fromJson(json["4"]),
      the5: json["5"] == null ? null : Distance.fromJson(json["5"]),
      all: json["all"] == null ? null : Distance.fromJson(json["all"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "1": the1?.toJson(),
        "2": the2?.toJson(),
        "3": the3?.toJson(),
        "4": the4?.toJson(),
        "5": the5?.toJson(),
        "all": all?.toJson(),
      };
}

class FiltersV2 {
  FiltersV2({
    required this.searchFilters,
    required this.filterSections,
    required this.metadata,
  });

  final List<dynamic> searchFilters;
  final List<FilterSection> filterSections;
  final Metadata? metadata;

  factory FiltersV2.fromJson(Map<String, dynamic> json) {
    return FiltersV2(
      searchFilters: json["search_filters"] == null
          ? []
          : List<dynamic>.from(json["search_filters"]!.map((x) => x)),
      filterSections: json["filter_sections"] == null
          ? []
          : List<FilterSection>.from(
              json["filter_sections"]!.map((x) => FilterSection.fromJson(x))),
      metadata:
          json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "search_filters": searchFilters.map((x) => x).toList(),
        "filter_sections": filterSections.map((x) => x?.toJson()).toList(),
        "metadata": metadata?.toJson(),
      };
}

class FilterSection {
  FilterSection({
    required this.label,
    required this.sectionId,
    required this.filterGroups,
    required this.parentSectionId,
  });

  final String? label;
  final String? sectionId;
  final List<FilterGroup> filterGroups;
  final String? parentSectionId;

  factory FilterSection.fromJson(Map<String, dynamic> json) {
    return FilterSection(
      label: json["label"],
      sectionId: json["section_id"],
      filterGroups: json["filter_groups"] == null
          ? []
          : List<FilterGroup>.from(
              json["filter_groups"]!.map((x) => FilterGroup.fromJson(x))),
      parentSectionId: json["parent_section_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "section_id": sectionId,
        "filter_groups": filterGroups.map((x) => x?.toJson()).toList(),
        "parent_section_id": parentSectionId,
      };
}

class FilterGroup {
  FilterGroup({
    required this.type,
    required this.key,
    required this.trackingKey,
    required this.label,
    required this.options,
  });

  final String? type;
  final String? key;
  final String? trackingKey;
  final String? label;
  final List<Option> options;

  factory FilterGroup.fromJson(Map<String, dynamic> json) {
    return FilterGroup(
      type: json["type"],
      key: json["key"],
      trackingKey: json["tracking_key"],
      label: json["label"],
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "key": key,
        "tracking_key": trackingKey,
        "label": label,
        "options": options.map((x) => x?.toJson()).toList(),
      };
}

class Option {
  Option({
    required this.label,
    required this.value,
    required this.selected,
    required this.optionDefault,
    required this.singleSelect,
    required this.count,
    required this.parentId,
  });

  final String? label;
  final String? value;
  final bool? selected;
  final bool? optionDefault;
  final bool? singleSelect;
  final String? count;
  final String? parentId;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      label: json["label"],
      value: json["value"],
      selected: json["selected"],
      optionDefault: json["default"],
      singleSelect: json["single_select"],
      count: json["count"],
      parentId: json["parent_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "selected": selected,
        "default": optionDefault,
        "single_select": singleSelect,
        "count": count,
        "parent_id": parentId,
      };
}

class Metadata {
  Metadata({
    required this.sort,
  });

  final String? sort;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      sort: json["sort"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sort": sort,
      };
}

class Paging {
  Paging({
    required this.results,
    required this.totalResults,
  });

  final String? results;
  final String? totalResults;

  factory Paging.fromJson(Map<String, dynamic> json) {
    return Paging(
      results: json["results"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
        "results": results,
        "total_results": totalResults,
      };
}
