import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/AppUrls.dart';
import 'package:http/http.dart' as http;
class Screen2Controller extends GetxController{

  RxBool isLoading = false.obs;
  RxInt currentIndex = 0.obs;
  RxInt pageIndex = 0.obs;
  RxInt selectedGoal = 1.obs;
  RxInt selectedActivityLevel = 1.obs;
  RxString selectedGender = 'Female'.obs;
  RxInt selectedWeight = 0.obs;
  RxInt selectedAge = 0.obs;
  RxString searchCountry = ''.obs;
  TextEditingController searchCountryController = TextEditingController();
  var ageController = TextEditingController().obs;
  RxList<int> selectedDietaryPreferences = <int>[].obs;
  RxList<int> selectedCuisinePreferences = <int>[].obs;
  var nameController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var  heightController = TextEditingController().obs;
  var  weightController = TextEditingController().obs;
  RxInt country = 1.obs;
  RxString countryString = ''.obs;
  RxString name = ''.obs;
  RxString phone = ''.obs;
  RxString city = ''.obs;
  RxString cmInchFeet = 'cm'.obs;
  RxString kgLbs = 'kg'.obs;
  var selectedDateOfBirth = DateTime.now().subtract(Duration(days: 365*18)).obs;
  // var selectedDateOfBirth = ''.obs;
  RxDouble selectedHeight = 0.0.obs;


  var headingList = [
    "What's your gender?",
    "What's your age?",
    "What's your height?",
    "What's your weight?",
    "What's your goal?",
    "What's your activity level?",
    'Select Dietary Preferences',
    'Select Cuisine Preferences',
  ];
  void resetAll(){
    pageIndex.value = 0 ;
    selectedGoal.value = 1;
    selectedActivityLevel.value = 1;
    selectedGender.value = 'Female';
    selectedWeight.value = 0;
    selectedDietaryPreferences.value = [];
    selectedCuisinePreferences.value = [];
    selectedDateOfBirth.value = DateTime.now().subtract(Duration(days: 365*18));
    selectedHeight.value = 0;
    nameController.value.text = '';
    cityController.value.text = '';
    phoneController.value.text = '';
  }
  var goals = [
    {'title':'Lose Weight','description':'Gradually achieve your ideal weight','icon':'assets/carrot.png','value':'1'},
    {'title':'Gain Muscle Weight','description':'Build lean muscle mass with a balanced plan','icon':'assets/muscle.png','value':'2'},
    {'title':'Maintain Weight','description':'Sustain your current weight with well-structured nutrition','icon':'assets/peanut.png','value':'3'},
  ];

  Future<void> getGoals()async{
    try{
      var url = AppUrls.lookup+'goal';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        try {
          for (int i = 0; i < data.length; i++) {
            String name = data[i]['name'];
            // Replace underscores with spaces and convert to lowercase.
            String formattedName = name.replaceAll('_', ' ').toLowerCase();
            // Capitalize the first letter of each word.
            formattedName = formattedName
                .split(' ')
                .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word)
                .join(' ');

            goals[i]['title'] = formattedName;
            goals[i]['value'] = data[i]['value'].toString();
          }
          print("GOALS AT TRY BLOCK");
          print(goals);
        } catch(e){

        }
      }else{
        goals = [
          {'title':'Weight Loss','description':'Gradually achieve your ideal weight','icon':'assets/carrot.png','value':'1'},
          {'title':'Muscle Gain','description':'Build lean muscle mass with a balanced plan','icon':'assets/muscle.png','value':'2'},
          {'title':'Maintain Weight','description':'Sustain your current weight with well-structured nutrition','icon':'assets/peanut.png','value':'3'},
        ];
      }


    }catch(e){
      goals = [
        {'title':'Weight Loss','description':'Gradually achieve your ideal weight','icon':'assets/carrot.png','value':'1'},
        {'title':'Muscle Gain','description':'Build lean muscle mass with a balanced plan','icon':'assets/muscle.png','value':'2'},
        {'title':'Maintain Weight','description':'Sustain your current weight with well-structured nutrition','icon':'assets/peanut.png','value':'3'},
      ];
    }
  }


  Future<void> getCountries()async{
    var countriesDuplicate = countries;
    try{
      var url = AppUrls.lookup+'country';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        try {
          for (int i = 0; i < data.length; i++) {
            String name = data[i]['name'];
            // Replace underscores with spaces and convert to lowercase.
            String formattedName = name.replaceAll('_', ' ').toLowerCase();
            // Capitalize the first letter of each word.
            formattedName = formattedName
                .split(' ')
                .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word)
                .join(' ');

            countries[i]['name'] = formattedName;
            countries[i]['id'] = data[i]['id'];
            countries[i]['code'] = data[i]['code'].toString();
            filteredCountries.value = countries;

          }
          print("COUNTRIIES AT TRY BLOCK");
          print(goals);
        } catch(e){
            countries = countriesDuplicate;
            filteredCountries.value = countries;

        }
      }else{
        countries = countriesDuplicate;
        filteredCountries.value = countries;

      }


    }catch(e){
      countries = countriesDuplicate;
    }
  }

  var activityLevels = [
    {'title':'No Exercise','description':'Sedentary Lifestyle','icon':'','value':'1' },
    {'title':'Lightly Active','description':'1-2 times/week','icon':'assets/dumbell.png','value':'2'},
    {'title':'Moderately Active','description':'2-4 times/week','icon':'assets/dumbell.png','value':'3'},
    {'title':'Very Active','description':'5-6 times/week','icon':'assets/dumbell.png','value':'4'},
    {'title':'Super Active','description':'6-7 times/week','icon':'assets/dumbell.png','value':'5'},
  ];

  Future<void> getActivity()async{
    try{
      var url = AppUrls.lookup+'activityLevel';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        try {
          for (int i = 0; i < data.length; i++) {
            String name = data[i]['name'];
            // Replace underscores with spaces and convert to lowercase.
            String formattedName = name.replaceAll('_', ' ').toLowerCase();
            // Capitalize the first letter of each word.
            formattedName = formattedName
                .split(' ')
                .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word)
                .join(' ');

            activityLevels[i]['title'] = formattedName;
            activityLevels[i]['value'] = data[i]['value'].toString();
          }
          print("GOALS AT TRY BLOCK");
          print(activityLevels);
        } catch(e){
          activityLevels = [
            {'title':'No Exercise','description':'Sedentary Lifestyle','icon':'','value':'1' },
            {'title':'Light Exercise','description':'1-2 times/week','icon':'assets/dumbell.png','value':'2'},
            {'title':'Moderate Exercise','description':'2-4 times/week','icon':'assets/dumbell.png','value':'3'},
            {'title':'Heavy Exercise','description':'5-6 times/week','icon':'assets/dumbell.png','value':'4'},
            {'title':'Athlete','description':'6-7 times/week','icon':'assets/dumbell.png','value':'5'},
          ];
        }
      }else{
        activityLevels = [
          {'title':'No Exercise','description':'Sedentary Lifestyle','icon':'','value':'1' },
          {'title':'Light Exercise','description':'1-2 times/week','icon':'assets/dumbell.png','value':'2'},
          {'title':'Moderate Exercise','description':'2-4 times/week','icon':'assets/dumbell.png','value':'3'},
          {'title':'Heavy Exercise','description':'5-6 times/week','icon':'assets/dumbell.png','value':'4'},
          {'title':'Athlete','description':'6-7 times/week','icon':'assets/dumbell.png','value':'5'},
        ];
      }


    }catch(e){
      activityLevels = [
        {'title':'No Exercise','description':'Sedentary Lifestyle','icon':'','value':'1' },
        {'title':'Light Exercise','description':'1-2 times/week','icon':'assets/dumbell.png','value':'2'},
        {'title':'Moderate Exercise','description':'2-4 times/week','icon':'assets/dumbell.png','value':'3'},
        {'title':'Heavy Exercise','description':'5-6 times/week','icon':'assets/dumbell.png','value':'4'},
        {'title':'Athlete','description':'6-7 times/week','icon':'assets/dumbell.png','value':'5'},
      ];
    }
  }

  var activityLevelTextIcons = [
    '🛌',            // No Exercise
    "👩🏻‍💻",    // Light Exercise
    '🏃',              // Moderate Exercise
    "🚴🏻‍♂️",              // Heavy Exercise
    "🔥",                  // Athlete
    "🔥",                  // Athlete
    "🔥",                  // Athlete
    "🔥",                  // Athlete
    "🔥",                  // Athlete
  ];
  var dietaryPreferencesIcons  = [
    "assets/balancedDiet.png",
    "assets/highProtiend.png",
    "assets/dairyFree.png",
    "assets/diabeticDiet.png",
    "assets/lowCarb.png",
    "assets/vegan.png",
    "assets/wheatFree.png",
    "assets/pescatarian.png",
    "assets/vegetarian.png",
    "assets/pescatarian.png",
    "assets/vegan.png",
    "assets/wheatFree.png",
    "assets/diabeticDiet.png",
    "assets/highProtiend.png",
  ];

  Future<void> getDietaryPreferences()async{
    try{
      var url = AppUrls.lookup+'dairyPreferences';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        try {
          for (int i = 0; i < data.length; i++) {
            String name = data[i]['name'];
            // Replace underscores with spaces and convert to lowercase.
            String formattedName = name.replaceAll('_', ' ').toLowerCase();
            // Capitalize the first letter of each word.
            formattedName = formattedName
                .split(' ')
                .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word)
                .join(' ');

            dietaryPreferences[i]['title'] = formattedName;
            dietaryPreferences[i]['value'] = data[i]['value'].toString();
          }
          print("GOALS AT TRY BLOCK");
          print(activityLevels);
        } catch(e){
          dietaryPreferences = [
            {'title':'Balanced Diet','value':'1'},
            {'title':'High Protein','value':'2'},
            {'title':'Dairy free','value':'3'},
            {'title':'Diabetic Diet','value':'4'},
            {'title':'Low Carb','value':'5'},
            {'title':'Vegan','value':'6'},
            {'title':'Wheat Free','value':'7'},
            {'title':'Pescatarian','value':'8'},
            {'title':'Vegetarian','value':'9'},
          ];

        }
      }else{
        dietaryPreferences = [
          {'title':'Balanced Diet','value':'1'},
          {'title':'High Protein','value':'2'},
          {'title':'Dairy free','value':'3'},
          {'title':'Diabetic Diet','value':'4'},
          {'title':'Low Carb','value':'5'},
          {'title':'Vegan','value':'6'},
          {'title':'Wheat Free','value':'7'},
          {'title':'Pescatarian','value':'8'},
          {'title':'Vegetarian','value':'9'},
        ];

      }


    }catch(e){
      dietaryPreferences = [
        {'title':'Balanced Diet','value':'1'},
        {'title':'High Protein','value':'2'},
        {'title':'Dairy free','value':'3'},
        {'title':'Diabetic Diet','value':'4'},
        {'title':'Low Carb','value':'5'},
        {'title':'Vegan','value':'6'},
        {'title':'Wheat Free','value':'7'},
        {'title':'Pescatarian','value':'8'},
        {'title':'Vegetarian','value':'9'},
      ];

    }
  }
  Future<void> getCuisinePreferences()async{
    try{
      var url = AppUrls.lookup+'cuisinePreferences';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        try {
          for (int i = 0; i < data.length; i++) {
            String name = data[i]['name'];
            // Replace underscores with spaces and convert to lowercase.
            String formattedName = name.replaceAll('_', ' ').toLowerCase();
            // Capitalize the first letter of each word.
            formattedName = formattedName
                .split(' ')
                .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word)
                .join(' ');

            cuisinePreferences[i]['title'] = formattedName;
            cuisinePreferences[i]['value'] = data[i]['value'].toString();
          }
          print("cuisine AT TRY BLOCK");
          print(cuisinePreferences);
        } catch(e){
          cuisinePreferences = [
            {
              'title': "English",
              'value':'1',
            },
            {
              'title': "Pakistani",
              'value':'2',
            },
            {
              'title': "Indian",
              'value':'3',
            },
            {

              'title': "Arabic",
              'value':'4',
            },
            {
              'title': "Italian",
              'value':'5',
            },
            {
              "name": "French",
              "value": '6'
            },
            {
              "name": "Chinese",
              "value": '7'
            },
            {
              "name": "Spanish",
              "value": '11'
            },
            {
              "name": "Thai",
              "value": '12'
            },
            {
              "name": "Mediterranean",
              "value": '13'
            },
            {
              "name": "Turkish",
              "value": '14'
            },
            {
              "name": "American",
              "value": '16'
            },
            {
              "name": "African",
              "value": '20'
            },
            {
              "name": "Russian",
              "value": '22'
            },
            {
              "name": "Filipino",
              "value": '26'
            }
          ];

        }
      }else{
        cuisinePreferences = [
          {
            'title': "English",
            'value':'1',
          },
          {
            'title': "Pakistani",
            'value':'2',
          },
          {
            'title': "Indian",
            'value':'3',
          },
          {

            'title': "Arabic",
            'value':'4',
          },
          {
            'title': "Italian",
            'value':'5',
          },
          {
            "name": "French",
            "value": '6'
          },
          {
            "name": "Chinese",
            "value": '7'
          },
          {
            "name": "Spanish",
            "value": '11'
          },
          {
            "name": "Thai",
            "value": '12'
          },
          {
            "name": "Mediterranean",
            "value": '13'
          },
          {
            "name": "Turkish",
            "value": '14'
          },
          {
            "name": "American",
            "value": '16'
          },
          {
            "name": "African",
            "value": '20'
          },
          {
            "name": "Russian",
            "value": '22'
          },
          {
            "name": "Filipino",
            "value": '26'
          }
        ];

      }


    }catch(e){
      cuisinePreferences = [
        {
          'title': "English",
          'value':'1',
        },
        {
          'title': "Pakistani",
          'value':'2',
        },
        {
          'title': "Indian",
          'value':'3',
        },
        {

          'title': "Arabic",
          'value':'4',
        },
        {
          'title': "Italian",
          'value':'5',
        },
        {
          "name": "French",
          "value": '6'
        },
        {
          "name": "Chinese",
          "value": '7'
        },
        {
          "name": "Spanish",
          "value": '11'
        },
        {
          "name": "Thai",
          "value": '12'
        },
        {
          "name": "Mediterranean",
          "value": '13'
        },
        {
          "name": "Turkish",
          "value": '14'
        },
        {
          "name": "American",
          "value": '16'
        },
        {
          "name": "African",
          "value": '20'
        },
        {
          "name": "Russian",
          "value": '22'
        },
        {
          "name": "Filipino",
          "value": '26'
        }
      ];

    }
  }
  var cuisinePreferences = [
    {
      'title': "English",
      'value':'1',
    },
    {
      'title': "Pakistani",
      'value':'2',
    },
    {
      'title': "Indian",
      'value':'3',
    },
    {

      'title': "Arabic",
      'value':'4',
    },
    {
      'title': "Italian",
      'value':'5',
    },
    {
      "name": "French",
      "value": '6'
    },
    {
      "name": "Chinese",
      "value": '7'
    },
    {
      "name": "Spanish",
      "value": '11'
    },
    {
      "name": "Thai",
      "value": '12'
    },
    {
      "name": "Mediterranean",
      "value": '13'
    },
    {
      "name": "Turkish",
      "value": '14'
    },
    {
      "name": "American",
      "value": '16'
    },
    {
      "name": "African",
      "value": '20'
    },
    {
      "name": "Russian",
      "value": '22'
    },
    {
      "name": "Filipino",
      "value": '26'
    }
  ];
  var dietaryPreferences = [
    {'title':'Balanced Diet','value':'1'},
    {'title':'High Protein','value':'2'},
    {'title':'Dairy free','value':'3'},
    {'title':'Diabetic Diet','value':'4'},
    {'title':'Low Carb','value':'5'},
    {'title':'Vegan','value':'6'},
    {'title':'Wheat Free','value':'7'},
    {'title':'Pescatarian','value':'8'},
    {'title':'Vegetarian','value':'9'},
  ];

  RxList filteredCountries = [].obs;
  void searchCountries({required String country}) {
    try {
      if (country.isNotEmpty) {
        filteredCountries.value = countries
            .where((element) => element['name']
            .toString()
            .toLowerCase()
            .startsWith(country.toLowerCase()))
            .toList();

        print("filteredCountries");
        print(filteredCountries.value.length);
        print("countries");
        print(countries.length);
      } else {
        filteredCountries.value = countries;
        print("filteredCountries");
        print(filteredCountries.value.length);
        print("countries");
        print(countries.length);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getDeviceCountry() {
    try {
      // Get the device's locale (e.g., "en_US", "fr_FR", "de_DE")
      String locale = Platform.localeName;

      // Extract country code (last part after "_")
      String countryCode = locale.split('_').last.toUpperCase(); // "US", "FR", etc.

      // Find the country in your list
      Map<String, dynamic>? matchedCountry = countries.firstWhere(
            (country) => country['code'].toString().toUpperCase() == countryCode,
        orElse: () => {},
      );

      if (matchedCountry.isNotEmpty) {
        print("Device Country Found: ${matchedCountry['name']}");
        countryString.value = matchedCountry['name'];
        country.value = matchedCountry['id'] as int;
        searchCountryController.text = matchedCountry['name'];
        searchCountries(country: countryString.value);
      } else {
        print("Device Country Not Found in List");
      }
    } catch (e) {
      print("Error getting country: $e");
    }
  }


 var countries = [
   {
     "id": 1,
     "name": "Afghanistan",
     "code": "AF"
   },
   {
     "id": 2,
     "name": "Albania",
     "code": "AL"
   },
   {
     "id": 3,
     "name": "Algeria",
     "code": "DZ"
   },
   {
     "id": 4,
     "name": "Andorra",
     "code": "AD"
   },
   {
     "id": 5,
     "name": "Angola",
     "code": "AO"
   },
   {
     "id": 6,
     "name": "Antigua and Barbuda",
     "code": "AG"
   },
   {
     "id": 7,
     "name": "Argentina",
     "code": "AR"
   },
   {
     "id": 8,
     "name": "Armenia",
     "code": "AM"
   },
   {
     "id": 9,
     "name": "Australia",
     "code": "AU"
   },
   {
     "id": 10,
     "name": "Austria",
     "code": "AT"
   },
   {
     "id": 11,
     "name": "Azerbaijan",
     "code": "AZ"
   },
   {
     "id": 12,
     "name": "Bahamas",
     "code": "BS"
   },
   {
     "id": 13,
     "name": "Bahrain",
     "code": "BH"
   },
   {
     "id": 14,
     "name": "Bangladesh",
     "code": "BD"
   },
   {
     "id": 15,
     "name": "Barbados",
     "code": "BB"
   },
   {
     "id": 16,
     "name": "Belarus",
     "code": "BY"
   },
   {
     "id": 17,
     "name": "Belgium",
     "code": "BE"
   },
   {
     "id": 18,
     "name": "Belize",
     "code": "BZ"
   },
   {
     "id": 19,
     "name": "Benin",
     "code": "BJ"
   },
   {
     "id": 20,
     "name": "Bhutan",
     "code": "BT"
   },
   {
     "id": 21,
     "name": "Bolivia",
     "code": "BO"
   },
   {
     "id": 22,
     "name": "Bosnia and Herzegovina",
     "code": "BA"
   },
   {
     "id": 23,
     "name": "Botswana",
     "code": "BW"
   },
   {
     "id": 24,
     "name": "Brazil",
     "code": "BR"
   },
   {
     "id": 25,
     "name": "Brunei",
     "code": "BN"
   },
   {
     "id": 26,
     "name": "Bulgaria",
     "code": "BG"
   },
   {
     "id": 27,
     "name": "Burkina Faso",
     "code": "BF"
   },
   {
     "id": 28,
     "name": "Burundi",
     "code": "BI"
   },
   {
     "id": 29,
     "name": "Cabo Verde",
     "code": "CV"
   },
   {
     "id": 30,
     "name": "Cambodia",
     "code": "KH"
   },
   {
     "id": 31,
     "name": "Cameroon",
     "code": "CM"
   },
   {
     "id": 32,
     "name": "Canada",
     "code": "CA"
   },
   {
     "id": 33,
     "name": "Central African Republic",
     "code": "CF"
   },
   {
     "id": 34,
     "name": "Chad",
     "code": "TD"
   },
   {
     "id": 35,
     "name": "Chile",
     "code": "CL"
   },
   {
     "id": 36,
     "name": "China",
     "code": "CN"
   },
   {
     "id": 37,
     "name": "Colombia",
     "code": "CO"
   },
   {
     "id": 38,
     "name": "Comoros",
     "code": "KM"
   },
   {
     "id": 39,
     "name": "Congo (Congo-Brazzaville)",
     "code": "CG"
   },
   {
     "id": 40,
     "name": "Congo (DRC)",
     "code": "CD"
   },
   {
     "id": 41,
     "name": "Costa Rica",
     "code": "CR"
   },
   {
     "id": 42,
     "name": "Croatia",
     "code": "HR"
   },
   {
     "id": 43,
     "name": "Cuba",
     "code": "CU"
   },
   {
     "id": 44,
     "name": "Cyprus",
     "code": "CY"
   },
   {
     "id": 45,
     "name": "Czechia",
     "code": "CZ"
   },
   {
     "id": 46,
     "name": "Denmark",
     "code": "DK"
   },
   {
     "id": 47,
     "name": "Djibouti",
     "code": "DJ"
   },
   {
     "id": 48,
     "name": "Dominica",
     "code": "DM"
   },
   {
     "id": 49,
     "name": "Dominican Republic",
     "code": "DO"
   },
   {
     "id": 50,
     "name": "Ecuador",
     "code": "EC"
   },
   {
     "id": 51,
     "name": "Egypt",
     "code": "EG"
   },
   {
     "id": 52,
     "name": "El Salvador",
     "code": "SV"
   },
   {
     "id": 53,
     "name": "Equatorial Guinea",
     "code": "GQ"
   },
   {
     "id": 54,
     "name": "Eritrea",
     "code": "ER"
   },
   {
     "id": 55,
     "name": "Estonia",
     "code": "EE"
   },
   {
     "id": 56,
     "name": "Eswatini",
     "code": "SZ"
   },
   {
     "id": 57,
     "name": "Ethiopia",
     "code": "ET"
   },
   {
     "id": 58,
     "name": "Fiji",
     "code": "FJ"
   },
   {
     "id": 59,
     "name": "Finland",
     "code": "FI"
   },
   {
     "id": 60,
     "name": "France",
     "code": "FR"
   },
   {
     "id": 61,
     "name": "Gabon",
     "code": "GA"
   },
   {
     "id": 62,
     "name": "Gambia",
     "code": "GM"
   },
   {
     "id": 63,
     "name": "Germany",
     "code": "DE"
   },
   {
     "id": 64,
     "name": "Ghana",
     "code": "GH"
   },
   {
     "id": 65,
     "name": "Greece",
     "code": "GR"
   },
   {
     "id": 66,
     "name": "Guatemala",
     "code": "GT"
   },
   {
     "id": 67,
     "name": "Honduras",
     "code": "HN"
   },
   {
     "id": 68,
     "name": "Hungary",
     "code": "HU"
   },
   {
     "id": 69,
     "name": "Iceland",
     "code": "IS"
   },
   {
     "id": 70,
     "name": "India",
     "code": "IN"
   },
   {
     "id": 71,
     "name": "Indonesia",
     "code": "ID"
   },
   {
     "id": 72,
     "name": "Iran",
     "code": "IR"
   },
   {
     "id": 73,
     "name": "Iraq",
     "code": "IQ"
   },
   {
     "id": 74,
     "name": "Ireland",
     "code": "IE"
   },
   {
     "id": 75,
     "name": "Italy",
     "code": "IT"
   },
   {
     "id": 76,
     "name": "Jamaica",
     "code": "JM"
   },
   {
     "id": 77,
     "name": "Japan",
     "code": "JP"
   },
   {
     "id": 78,
     "name": "Jordan",
     "code": "JO"
   },
   {
     "id": 79,
     "name": "Kazakhstan",
     "code": "KZ"
   },
   {
     "id": 80,
     "name": "Kenya",
     "code": "KE"
   },
   {
     "id": 81,
     "name": "Kiribati",
     "code": "KI"
   },
   {
     "id": 82,
     "name": "Kuwait",
     "code": "KW"
   },
   {
     "id": 83,
     "name": "Kyrgyzstan",
     "code": "KG"
   },
   {
     "id": 84,
     "name": "Laos",
     "code": "LA"
   },
   {
     "id": 85,
     "name": "Latvia",
     "code": "LV"
   },
   {
     "id": 86,
     "name": "Lebanon",
     "code": "LB"
   },
   {
     "id": 87,
     "name": "Lesotho",
     "code": "LS"
   },
   {
     "id": 88,
     "name": "Liberia",
     "code": "LR"
   },
   {
     "id": 89,
     "name": "Libya",
     "code": "LY"
   },
   {
     "id": 90,
     "name": "Liechtenstein",
     "code": "LI"
   },
   {
     "id": 91,
     "name": "Lithuania",
     "code": "LT"
   },
   {
     "id": 92,
     "name": "Luxembourg",
     "code": "LU"
   },
   {
     "id": 93,
     "name": "Madagascar",
     "code": "MG"
   },
   {
     "id": 94,
     "name": "Malawi",
     "code": "MW"
   },
   {
     "id": 95,
     "name": "Malaysia",
     "code": "MY"
   },
   {
     "id": 96,
     "name": "Maldives",
     "code": "MV"
   },
   {
     "id": 97,
     "name": "Mali",
     "code": "ML"
   },
   {
     "id": 98,
     "name": "Malta",
     "code": "MT"
   },
   {
     "id": 99,
     "name": "Mexico",
     "code": "MX"
   },
   {
     "id": 100,
     "name": "Moldova",
     "code": "MD"
   },
   {
     "id": 101,
     "name": "Monaco",
     "code": "MC"
   },
   {
     "id": 102,
     "name": "Mongolia",
     "code": "MN"
   },
   {
     "id": 103,
     "name": "Montenegro",
     "code": "ME"
   },
   {
     "id": 104,
     "name": "Morocco",
     "code": "MA"
   },
   {
     "id": 105,
     "name": "Mozambique",
     "code": "MZ"
   },
   {
     "id": 106,
     "name": "Myanmar",
     "code": "MM"
   },
   {
     "id": 107,
     "name": "Namibia",
     "code": "NA"
   },
   {
     "id": 108,
     "name": "Nauru",
     "code": "NR"
   },
   {
     "id": 109,
     "name": "Nepal",
     "code": "NP"
   },
   {
     "id": 110,
     "name": "Netherlands",
     "code": "NL"
   },
   {
     "id": 111,
     "name": "New Zealand",
     "code": "NZ"
   },
   {
     "id": 112,
     "name": "Nicaragua",
     "code": "NI"
   },
   {
     "id": 113,
     "name": "Niger",
     "code": "NE"
   },
   {
     "id": 114,
     "name": "Nigeria",
     "code": "NG"
   },
   {
     "id": 115,
     "name": "North Korea",
     "code": "KP"
   },
   {
     "id": 116,
     "name": "North Macedonia",
     "code": "MK"
   },
   {
     "id": 117,
     "name": "Norway",
     "code": "NO"
   },
   {
     "id": 118,
     "name": "Oman",
     "code": "OM"
   },
   {
     "id": 119,
     "name": "Pakistan",
     "code": "PK"
   },
   {
     "id": 120,
     "name": "Palau",
     "code": "PW"
   },
   {
     "id": 121,
     "name": "Panama",
     "code": "PA"
   },
   {
     "id": 122,
     "name": "Papua New Guinea",
     "code": "PG"
   },
   {
     "id": 123,
     "name": "Paraguay",
     "code": "PY"
   },
   {
     "id": 124,
     "name": "Peru",
     "code": "PE"
   },
   {
     "id": 125,
     "name": "Philippines",
     "code": "PH"
   },
   {
     "id": 126,
     "name": "Poland",
     "code": "PL"
   },
   {
     "id": 127,
     "name": "Portugal",
     "code": "PT"
   },
   {
     "id": 128,
     "name": "Qatar",
     "code": "QA"
   },
   {
     "id": 129,
     "name": "Romania",
     "code": "RO"
   },
   {
     "id": 130,
     "name": "Russia",
     "code": "RU"
   },
   {
     "id": 131,
     "name": "Rwanda",
     "code": "RW"
   },
   {
     "id": 132,
     "name": "Saint Kitts and Nevis",
     "code": "KN"
   },
   {
     "id": 133,
     "name": "Saint Lucia",
     "code": "LC"
   },
   {
     "id": 134,
     "name": "Samoa",
     "code": "WS"
   },
   {
     "id": 135,
     "name": "Saudi Arabia",
     "code": "SA"
   },
   {
     "id": 136,
     "name": "Senegal",
     "code": "SN"
   },
   {
     "id": 137,
     "name": "Serbia",
     "code": "RS"
   },
   {
     "id": 138,
     "name": "Seychelles",
     "code": "SC"
   },
   {
     "id": 139,
     "name": "Singapore",
     "code": "SG"
   },
   {
     "id": 140,
     "name": "Slovakia",
     "code": "SK"
   },
   {
     "id": 141,
     "name": "Slovenia",
     "code": "SI"
   },
   {
     "id": 142,
     "name": "Solomon Islands",
     "code": "SB"
   },
   {
     "id": 143,
     "name": "South Africa",
     "code": "ZA"
   },
   {
     "id": 144,
     "name": "South Korea",
     "code": "KR"
   },
   {
     "id": 145,
     "name": "Spain",
     "code": "ES"
   },
   {
     "id": 146,
     "name": "Sri Lanka",
     "code": "LK"
   },
   {
     "id": 147,
     "name": "Sudan",
     "code": "SD"
   },
   {
     "id": 148,
     "name": "Sweden",
     "code": "SE"
   },
   {
     "id": 149,
     "name": "Switzerland",
     "code": "CH"
   },
   {
     "id": 150,
     "name": "Syria",
     "code": "SY"
   },
   {
     "id": 151,
     "name": "Tajikistan",
     "code": "TJ"
   },
   {
     "id": 152,
     "name": "Tanzania",
     "code": "TZ"
   },
   {
     "id": 153,
     "name": "Thailand",
     "code": "TH"
   },
   {
     "id": 154,
     "name": "Togo",
     "code": "TG"
   },
   {
     "id": 155,
     "name": "Tonga",
     "code": "TO"
   },
   {
     "id": 156,
     "name": "Tunisia",
     "code": "TN"
   },
   {
     "id": 157,
     "name": "Turkey",
     "code": "TR"
   },
   {
     "id": 158,
     "name": "Turkmenistan",
     "code": "TM"
   },
   {
     "id": 159,
     "name": "Uganda",
     "code": "UG"
   },
   {
     "id": 160,
     "name": "Ukraine",
     "code": "UA"
   },
   {
     "id": 161,
     "name": "United Arab Emirates",
     "code": "AE"
   },
   {
     "id": 162,
     "name": "United Kingdom",
     "code": "GB"
   },
   {
     "id": 163,
     "name": "United States",
     "code": "US"
   },
   {
     "id": 164,
     "name": "Uruguay",
     "code": "UY"
   },
   {
     "id": 165,
     "name": "Uzbekistan",
     "code": "UZ"
   },
   {
     "id": 166,
     "name": "Vanuatu",
     "code": "VU"
   },
   {
     "id": 167,
     "name": "Vatican City",
     "code": "VA"
   },
   {
     "id": 168,
     "name": "Venezuela",
     "code": "VE"
   },
   {
     "id": 169,
     "name": "Vietnam",
     "code": "VN"
   },
   {
     "id": 170,
     "name": "Yemen",
     "code": "YE"
   },
   {
     "id": 171,
     "name": "Zambia",
     "code": "ZM"
   },
   {
     "id": 172,
     "name": "Zimbabwe",
     "code": "ZW"
   }
 ];
}