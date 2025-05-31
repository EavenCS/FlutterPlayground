import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/widgets.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("App Settings"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color.fromARGB(255, 239, 239, 239),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("General", style: settingsHeaderStyle()),
                    const Divider(height: 20.0, thickness: 1.0),

                    const SizedBox(height: 10),
                    settingsListTileStyle(
                      "Profile",
                      Icons.arrow_forward_ios,
                      Icons.person,
                    ),
                    settingsListTileStyle(
                      "Password",
                      Icons.arrow_forward_ios,
                      Icons.lock,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: const Color.fromARGB(255, 239, 239, 239),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data", style: settingsHeaderStyle()),
                    const Divider(height: 20.0, thickness: 1.0),
                    settingsListTileStyle(
                      "CSV",
                      Icons.arrow_forward_ios,
                      Icons.download,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: const Color.fromARGB(255, 239, 239, 239),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text("More", style: settingsHeaderStyle()),
                    const Divider(height: 20.0, thickness: 1.0),
                    settingsListTileStyle(
                      "Rate & Review",
                      Icons.arrow_forward_ios,
                      Icons.star_rate_sharp,
                    ),
                    settingsListTileStyle(
                      "Help",
                      Icons.arrow_forward_ios,
                      Icons.info_sharp,
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
}
