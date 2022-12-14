// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ExternalCampaign extends StatelessWidget {
  final String campaignName;
  final String logoImagePath;
  final String websiteLink;
  final String field;

  const ExternalCampaign(
      {required this.campaignName,
      required this.logoImagePath,
      required this.websiteLink,
      required this.field});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: const Color(0xFF367D38)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF367D38)),
                    ),
                    height: 55,
                    padding: const EdgeInsets.all(1),
                    child: Image.asset(logoImagePath),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaignName,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Link(
              target: LinkTarget.blank,
              uri: Uri.parse(websiteLink),
              builder: (BuildContext context, followLink) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[500],
                ),
                onPressed: followLink,
                child: const Icon(
                  Icons.open_in_new,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
