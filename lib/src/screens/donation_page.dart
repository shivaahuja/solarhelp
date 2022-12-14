import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/external_campaign.dart';
import 'package:solarhelp/src/screens/navigation.dart';
import 'package:url_launcher/link.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final List externalCampaign = [
    [
      'Defense Fund',
      'lib/src/images/EDF.png',
      'https://www.edf.org/donate/?addl_info=nav-button|top_nav_donate_btn-test&ut_sid=29cfd1c2-aa74-48dc-85a0-86451831a86b&ut_pid=c01aebd2-74eb-414c-88cf-a6d574f99b63&conversion_pg=www.edf.org%2F&landing_pg=www.edf.org%2F&landing_pg_1st_visit=www.edf.org%2F&source_1st_visit=guides.lib.berkeley.edu&subsource_1st_visit=%2F&custom_source=guides.lib.berkeley.edu&custom_sub_source=%2F&custom_transfer=1661944759616',
      'Environment'
    ],
    [
      'World Wild Life',
      'lib/src/images/wwf.png',
      'https://support.worldwildlife.org/site/SPageServer?pagename=main_monthly&s_src=AWE2209OQ18299A01179RX&s_subsrc=topnav&_ga=2.192281196.755866945.1661945353-294944245.1661945351',
      'Animals'
    ],
    [
      'Fauna & Flora',
      'lib/src/images/faf.png',
      'https://www.fauna-flora.org/support/',
      'Environment'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF367D38)),
                borderRadius: BorderRadius.circular(12),
                color: Colors.green[400],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Navigation(currentIndex: 1)));
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Donate For A Greener Earth',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Reforestation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 215,
            child: Center(
              child: Link(
                uri: Uri.parse('https://paypal.me/donationfortrees'),
                builder: (context, followLink) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300]),
                  onPressed: followLink,
                  child: Image.asset('lib/src/images/Plantingtrees.png'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Other Campaigns',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5.0),
                itemCount: externalCampaign.length,
                itemBuilder: (context, index) {
                  return ExternalCampaign(
                    campaignName: externalCampaign[index][0],
                    logoImagePath: externalCampaign[index][1],
                    websiteLink: externalCampaign[index][2],
                    field: externalCampaign[index][3],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
