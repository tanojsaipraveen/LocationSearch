String weatherConditions() {
  String res = '''
{
   "Raniny":{
      "Essentials":[
         "Waterproof Jacket",
         "Waterproof Pants",
         "Waterproof Shoes/Boots",
         "Umbrella",
         "Moisture-Wicking Clothes",
         "Hat or Cap"
      ]
   },
   "Snowy":{
      "Essentials":[
         "Heavy Coat/Jacket",
         "Insulated Pants",
         "Waterproof Boots",
         "Hat/Beanie",
         "Gloves/Mittens",
         "Scarf",
         "Thermal Underwear"
      ]
   },
   "Sunny":{
      "Essentials":[
         "T-shirts/Tops",
         "Shorts/Skirts",
         "Sunglasses",
         "Sunscreen",
         "Hat/Cap",
         "Sandals/Flip-flops"
      ]
   },
   "Mostly Cloudy":{
      "Essentials":[
         "Light Jacket",
         "Long-sleeve Shirt",
         "Jeans/Pants",
         "Hat/Cap",
         "Sunglasses",
         "Comfortable Shoes"
      ]
   }
}''';
  return res;
}
