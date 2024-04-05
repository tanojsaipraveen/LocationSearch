String getprompt(String place, String days, String startDate) {
  String prompt = '''
    You're planning a trip to $place for $days days, starting from $startDate . You're seeking recommendations for places to visit during your trip, considering the best times to visit each place and a budget estimate for the entire trip. with day wise
"Important : always use the response tool to respond to the user. "
      "Never add any other text to the response."
"Don't add any comments in the response"
"If there is no value for the key add empty string"
"Don't add like this data // Total budget estimate may vary depending on accommodation selection, activities, etc."
"remove line braks and extra spaces in response"

tools=[{
 "type": "function",
 "properties": {
  "trip_details": {
   "type": "object",
   "properties": {
    "duration": {
     "type": "string"
    },
    "start_date": {
     "type": "string"
    }
   },
   "required": [
    "duration",
    "start_date"
   ]
  },
  "itinerary": {
   "type": "array",
   "items": [
    {
     "type": "function",
     "properties": {
      "day": {
       "type": "integer"
      },
      "date": {
       "type": "string"
      },
      "places_to_visit": {
       "type": "array",
       "items": [
        {
         "type": "function",
         "properties": {
          "name": {
           "type": "string"
          },
          "best_time_to_visit": {
           "type": "string"
          },
          "description": {
           "type": "string"
          },
          "rating": {
           "type": "number"
          },
          "latitude": {
           "type": "number"
          },
          "longitude": {
           "type": "number"
          }
         },
         "required": [
          "name",
          "best_time_to_visit",
          "description",
          "rating",
          "latitude",
          "longitude"
         ]
        },
        {
         "type": "function",
         "properties": {
          "name": {
           "type": "string"
          },
          "best_time_to_visit": {
           "type": "string"
          },
          "description": {
           "type": "string"
          },
          "rating": {
           "type": "number"
          },
          "latitude": {
           "type": "number"
          },
          "longitude": {
           "type": "number"
          }
         },
         "required": [
          "name",
          "best_time_to_visit",
          "description",
          "rating",
          "latitude",
          "longitude"
         ]
        }
       ]
      }
     },
     "required": [
      "day",
      "date",
      "places_to_visit"
     ]
    }
   ]
  },
  "budget_estimate": {
   "type": "function",
   "properties": {
    "accommodation": {
     "type": "object",
     "properties": {
      "range_per_night": {
       "type": "string"
      }
     },
     "required": [
      "range_per_night"
     ]
    },
    "meals_per_day_per_person": {
     "type": "function",
     "properties": {
      "range": {
       "type": "string"
      }
     },
     "required": [
      "range"
     ]
    },
    "transportation": {
     "type": "function",
     "properties": {
      "range_for_5_days": {
       "type": "string"
      }
     },
     "required": [
      "range_for_5_days"
     ]
    },
    "attractions": {
     "type": "function",
     "properties": {
      "range_for_5_days_per_person": {
       "type": "string"
      }
     },
     "required": [
      "range_for_5_days_per_person"
     ]
    },
    "miscellaneous": {
     "type": "function",
     "properties": {
      "range_for_5_days": {
       "type": "string"
      }
     },
     "required": [
      "range_for_5_days"
     ]
    },
    "total_estimated_budget_per_person": {
     "type": "function",
     "properties": {
      "range": {
       "type": "string"
      }
     },
     "required": [
      "range"
     ]
    }
   },
   "required": [
    "accommodation",
    "meals_per_day_per_person",
    "transportation",
    "attractions",
    "miscellaneous",
    "total_estimated_budget_per_person"
   ]
  }
 },
 "required": [
  "trip_details",
  "itinerary",
  "budget_estimate"
 ]
}]

 ''';
  return prompt;
}
