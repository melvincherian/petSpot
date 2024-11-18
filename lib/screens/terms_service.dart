import 'package:flutter/material.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
//         leading: IconButton(
//           color: Colors.white,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//            Navigator.pushAndRemoveUntil(
//   context,
//   MaterialPageRoute(builder: (context) =>const ProfileScreen()),
//   (Route<dynamic> route) => false, // This predicate removes all routes from the stack
// );
//           },
//         ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to our Pet Store App!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please read the following terms and conditions carefully before using our app.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSection(
                      title: "1. User Agreement",
                      content:
                          "By using this app, you agree to comply with these terms and conditions. We may modify these terms at any time without notice, so please check regularly.",
                    ),
                    const Divider(),
                    buildSection(
                      title: "2. Product Availability",
                      content:
                          "Our pet products and services may vary depending on availability and location. We make no guarantees on stock or availability.",
                    ),
                    const Divider(),
                    buildSection(
                      title: "3. User Conduct",
                      content:
                          "Users are expected to behave responsibly and use our app ethically. Any misuse, including fraud, may result in account termination.",
                    ),
                    const Divider(),
                    buildSection(
                      title: "4. Payment and Refunds",
                      content:
                          "All payments are securely processed. Refunds are provided as per our refund policy, and we reserve the right to refuse refunds in certain cases.",
                    ),
                    const Divider(),
                    buildSection(
                      title: "5. Limitation of Liability",
                      content:
                          "We are not responsible for any direct, indirect, or consequential damages arising from your use of our app.",
                    ),
                    const Divider(),
                    buildSection(
                      title: "6. Privacy Policy",
                      content:
                          "Your privacy is important to us. Please refer to our Privacy Policy for details on how we handle your data.",
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Thank you for choosing our App!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
