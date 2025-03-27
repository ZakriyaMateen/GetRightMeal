import 'package:flutter/material.dart';
import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Widgets/Text.dart';
import '../../main.dart';
import '../AuthViews/RegisterPage.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  void showPackageDetails() async {

    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => RegisterPage(name: '',),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: w,
        height: h*0.90,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        ),
        child: SafeArea(

          child: Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              title:  MyText(title:'Choose Your Plan',fontWeight: w500,),
              backgroundColor: white,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PlanCard(
                    title: "Basic Plan",
                    description: "Get access to limited features",
                    price: "AED 6.58/month",
                    onTap: showPackageDetails,
                  ),
                  const SizedBox(height: 16),
                  PlanCard(
                    title: "Premium Plan",
                    description: "Unlock all features with priority support",
                    price: "AED 13.18/month",
                    onTap: showPackageDetails,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: plumGrey),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: MyText(

                        title: 'Select',fontWeight: w600,size: size17,color: white,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
