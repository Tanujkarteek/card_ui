import 'package:flutter/material.dart';
import 'package:test/screens/add_to_gpay.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddToGpay()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Color(0xFFC0B2E6)),
              gradient: LinearGradient(
                colors: [
                  Color(0xAFC7CAFF),
                  Color(0xAFECE2FF),
                  Color(0xAFF9F0FF),
                  Color(0xAFECE2FF),
                  Color(0xAFC7CAFF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Image.asset('assets/images/gpay.png', height: 32),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Pay safer & faster with Google Pay",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Set up your card with Google Pay. It's easy!",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    ],
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
