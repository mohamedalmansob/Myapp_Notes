import 'package:flutter/material.dart';
class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade700,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200,left: 40,right: 40),
            child: Container(
              width: 400,
              height: 400,
              decoration:  BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )
              ),

            ),
          ),
        ],
      ),
    );
  }
}
