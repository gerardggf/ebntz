import 'package:flutter/material.dart';

class OptionsDrawer extends StatelessWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 5,
          ),
          child: ListView(
            children: [
              const Text(
                'eBntz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: const Text('Compartir nuevo evento'),
                leading: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
