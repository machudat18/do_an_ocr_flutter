import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;

  final String value;

  const CustomTextField({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14)),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 2,
              color: Colors.black,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  side: BorderSide(color: Colors.grey, width: 0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
