import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';


class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppBar(title: "save screen")
      
      
      
      
    );
  }
}
