import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:greentracker/constants.dart';

class DeliverControlScreen extends StatefulWidget {
  final int id;
  const DeliverControlScreen({super.key, required this.id});

  @override
  State<DeliverControlScreen> createState() => _DeliverControlScreenState();
}

class _DeliverControlScreenState extends State<DeliverControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Tracker'),
        backgroundColor: kPrimaryColor,
      ),
      body: const Placeholder(),
    );
  }
}
