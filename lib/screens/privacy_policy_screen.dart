import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Privacy Policy for Study Pal",
                style: TextStyle(fontSize: 25),
              ),
              const Text("Last updated: May 22, 2024"),
              const SizedBox(height: 10),
              title("Introduction"),
              const SizedBox(height: 5),
              const Text(
                "Welcome to Study Pal. Your privacy is important to us. This privacy policy outlines how we handle your personal information when you use our app. Since Study Pal primarily functions offline and stores all data locally on your device, it offers enhanced security and privacy."
              ),
              const SizedBox(height: 10),
              title("Information We Collect"),
              const SizedBox(height: 5),
              const Text(
                "We collect information that you provide directly when you use our app, such as:\n\n"
                "Personal Information: Name, email address, and any other personal information you choose to enter.\n\n"
                "Usage Data: Information about how you use the app, including the features you use, tasks you create, and the time spent on the app."
              ),
              const SizedBox(height: 10),
              title("How We Use Your Information"),
              const SizedBox(height: 5),
              const Text(
                "We use the information we collect in the following ways:\n\n"
                "To Provide and Maintain Our Service: Including creating and managing your tasks, schedules, and timer settings.\n\n"
                "To Enhance Security: Password protection ensures that your data is secure and accessible only to you.\n\n"
                "To Provide Motivation Quotes: We retrieve motivation quotes from a REST API to enhance your user experience."
              ),
              const SizedBox(height: 10),
              title("Data Storage and Security"),
              const SizedBox(height: 5),
              const Text(
                "All data, including schedules and tasks, is stored locally on your device and is not transmitted over the internet, except for retrieving motivation quotes. This enhances the security and privacy of your information. We implement password protection to ensure that only you can access your schedules and tasks."
              ),
              const SizedBox(height: 10),
              title("Your Privacy Rights"),
              const SizedBox(height: 5),
              const Text(
                "Because Study Pal does not collect or transmit data to our servers, your personal information is fully under your control. You have the following rights regarding your information:\n\n"
                "Access: You can access all the information stored in the app directly through the app interface.\n\n"
                "Correction: You can correct any inaccuracies by editing your information within the app.\n\n"
                "Deletion: You can delete your data by removing the app from your device."
              ),
              const SizedBox(height: 10),
              title("Third-Party Services"),
              const SizedBox(height: 5),
              const Text(
                "To provide motivation quotes, Study Pal accesses a REST API. This service may collect certain data as specified in their privacy policy. Please review their privacy policy for more information."
              ),
              const SizedBox(height: 10),
              title("Changes to This Privacy Policy"),
              const SizedBox(height: 5),
              const Text(
                "We may update this privacy policy from time to time to reflect changes to our practices or for other operational, legal, or regulatory reasons. We will notify you of any changes by posting the new privacy policy on this page."
              ),
              const SizedBox(height: 10),
              title("Contact Us"),
              const SizedBox(height: 5),
              const Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    "If you have any questions about this privacy policy or our privacy practices, please contact us at "
                  ),
                  Text("ashiruakored@gmail.com",style: TextStyle(color: Colors.blueAccent),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
