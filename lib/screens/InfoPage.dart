import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 1,
          backgroundColor: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
