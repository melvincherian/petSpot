import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/screens/video_conference.dart';

class VideoDetail extends StatefulWidget {
  const VideoDetail({super.key});

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  final TextEditingController textEditingController = TextEditingController();

  Future<void> storeConferenceID(String conferenceID) async {
    if (conferenceID.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('video_conferences').add({
          'conferenceID': conferenceID,
          'createdAt': Timestamp.now(),
        });
        print("Conference ID stored successfully");
      } catch (e) {
        print("Error storing conference ID: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Video Conference',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter Conference ID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter Call ID To join',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String conferenceID = textEditingController.text.trim();
                if (conferenceID.isNotEmpty) {
                  await storeConferenceID(conferenceID);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoConference(conferenceID: conferenceID),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Join Conference',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Colors.black ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}