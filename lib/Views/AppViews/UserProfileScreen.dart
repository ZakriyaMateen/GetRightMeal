import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Controllers/OnBoardingControllers/Screen2Controller.dart';
import '../../Models/UserProfileModel.dart';
import '../../Widgets/Text.dart';

class UserProfileScreen extends StatefulWidget {
  final UserProfileModel userProfile;

  UserProfileScreen({required this.userProfile});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<String> dietaryPrefs = [];
  ScrollController _scrollController = ScrollController();
  RxBool showUserName = false.obs;

  @override
  void initState() {
    print('GOOOALLL: ');
    print(widget.userProfile.profile!.goal);
    print(widget.userProfile.profile!.activityLevel);
    super.initState();
    for (String indexStr in widget.userProfile.profile!.dairyPreferences!) {
      int? index = int.tryParse(indexStr);
      if (index != null && index >= 0 && index < Screen2Controller().dietaryPreferences.length) {
        // dietaryPrefs.add(Screen2Controller().dietaryPreferences[index]);
      }
    }
    _scrollController.addListener(() {
      showUserName.value = _scrollController.offset > 158;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(

        title: Obx(() => MyText(
          title: showUserName.value ? widget.userProfile.name : 'User Profile',
          size: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        )),
        backgroundColor: beige,
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildInfoCard('Phone', widget.userProfile!.profile!.phone!, '☎️'),
            _buildInfoCard('City', widget.userProfile!.profile!.city!, "🏘️"),
            _buildInfoCard('Country', Screen2Controller().countries
                .firstWhere(
                  (v) => v['id'] == widget.userProfile.profile!.country!,
              orElse: () => {'name': 'Select Country'},
            )['name']
                .toString()
                , "🗺"),
            _buildInfoCard('Date of Birth', _formatDate(widget!.userProfile.profile!.dateOfBirth!), "🎂"),
            _buildInfoCard('Gender', widget.userProfile!.profile!.gender!, '⚤'),
            _buildInfoCard('Height', '${widget.userProfile.profile!.height} ${widget.userProfile!.profile!.heightUnit.toString()}', "↕"),
            _buildInfoCard('Weight', '${widget.userProfile.profile!.weight} ${widget.userProfile!.profile!.weightUnit.toString()}', "⏲️"),
            _buildInfoCard('Age', '${widget.userProfile.profile!.age} years', "📆"),
            _buildInfoCard('Goal', _getGoalName(widget.userProfile!.profile!.goal!), "🎯"),
            _buildInfoCard('Activity Level', _getActivityLevel(widget.userProfile.profile!.activityLevel!), "🏋️"),
            SizedBox(height: 20),
            // _buildPreferencesSection('Dietary Preferences', dietaryPrefs),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: red.withOpacity(0.2),
            backgroundImage: AssetImage(widget.userProfile.profile!.gender=='female'?'assets/profileImage.png':'assets/man.png'),
          ),
          SizedBox(height: 12),
          MyText(
            title: widget.userProfile.name,
            size: 28,
            fontWeight: FontWeight.bold,
            color: dustyRose,
          ),
          SizedBox(height: 6),
          MyText(
            title: widget.userProfile.email,
            size: 16,
            color: plumGrey!,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String icon) {
    return Card(
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            MyText(
              title: icon,
              size: 25,
            ),
            // Icon(icon, size: 30, color: plumGrey),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: title,
                    size: 16,
                    fontWeight: FontWeight.w700,
                    color: dustyRose!,
                  ),
                  SizedBox(height: 4),
                  MyText(
                    title: value,
                    size: 14,
                    color: plumGrey!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(String title, List<String> preferences) {
    return Card(
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              title: '📋️',
              size: 25,
            ),
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: title,
                  size: 18,
                  fontWeight: FontWeight.bold,
                  color: dustyRose,
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: preferences
                      .map((preference) => Chip(
                    label: MyText(
                      title: preference,
                      size: 14,
                      color: beige,
                    ),
                    backgroundColor: red.withOpacity(0.5),
                  ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getCountryName(int countryId) {
    return 'Country #$countryId';
  }

  String _getGoalName(int goal) {
    switch (goal) {
      case 1:
        return 'Lose Weight';
      case 2:
        return 'Gain Muscle Weight';
      case 3:
        return 'Maintain Weight';
      default:
        return 'Unknown Goal';
    }
  }

  String _getActivityLevel(int level) {
    switch (level) {
      case 1:
        return 'No Exercise';
      case 2:
        return 'Lightly Active';
      case 3:
        return 'Moderately Active';
      case 4:
        return 'Very Active';
      case 5:
        return 'Super Active';
      default:
        return 'Unknown Level';
    }
  }
}
