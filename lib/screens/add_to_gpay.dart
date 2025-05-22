import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToGpay extends StatefulWidget {
  const AddToGpay({super.key});

  @override
  State<AddToGpay> createState() => _AddToGpayState();
}

class _AddToGpayState extends State<AddToGpay> {
  String url = 'https://682eef14746f8ca4a47f019b.mockapi.io/card';
  List<dynamic> cards = [];
  int selectedIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          cards = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void showBottomSheet(
    String cardNickName,
    String cardNumber,
    String cardType,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          height: 500,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This card is already added to\nGoogle Pay',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF0B103A),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 12),
              Text(
                'Safely make in-store and online purchases.',
                style: TextStyle(fontSize: 16, color: Color(0xFF3C4061)),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: FullCard(
                  cardNickName: cardNickName,
                  cardNumber: cardNumber,
                  cardType: cardType,
                ),
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    side: WidgetStateProperty.all(
                      BorderSide(color: Color(0xFF3C4061)),
                    ),
                  ),
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 16, color: Color(0xFF3C4061)),
                  ),
                ),
              ),
              SizedBox(height: 42),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      appBar: AppBar(
        backgroundColor: Color(0xFF101010),
        foregroundColor: Color(0xFFFCFCFC),
        title: Text(
          'Add to Google Pay',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFFFCFCFC),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 48),
            Image.asset('assets/images/gpay.png'),
            SizedBox(height: 36),
            Text(
              "Say hello to effortless and\nsecure payments",
              style: TextStyle(
                fontSize: 26,
                color: Color(0xFF0B103A),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
            Text(
              "Add your Alaan card to Google Pay and enjoy\nquick, secure payments wherever you go.",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6D7089),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            isLoading
                ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF0B103A),
                      ),
                    ),
                  ),
                )
                : Scrollbar(
                  thickness: 6,
                  radius: Radius.circular(10),
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: CardItem(
                            isSelected: index == selectedIndex,
                            cardNickName: cards[index]['cardNickName'],
                            cardNumber: cards[index]['last4Digits'],
                            cardType: cards[index]['type'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  showBottomSheet(
                    cards[selectedIndex]['cardNickName'],
                    cards[selectedIndex]['last4Digits'],
                    cards[selectedIndex]['type'],
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add to ",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Image.asset('assets/images/gpay_logo.png', height: 28),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Maybe later",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3C4061),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final bool isSelected;
  final String cardNickName;
  final String cardNumber;
  final String cardType;

  const CardItem({
    super.key,
    required this.isSelected,
    required this.cardNickName,
    required this.cardNumber,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              cardType.toLowerCase() == 'physical'
                  ? Image.asset('assets/images/card_physical.png', height: 32)
                  : Image.asset('assets/images/card_virtual.png', height: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardNickName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0B103A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${cardType.capitalize()} ...$cardNumber',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6D7089),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        : Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF9F9FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              cardType.toLowerCase() == 'physical'
                  ? Image.asset('assets/images/card_physical.png', height: 32)
                  : Image.asset('assets/images/card_virtual.png', height: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardNickName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0B103A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${cardType.capitalize()} ...$cardNumber',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6D7089),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}

class FullCard extends StatelessWidget {
  final String cardNickName;
  final String cardNumber;
  final String cardType;

  const FullCard({
    super.key,
    required this.cardNickName,
    required this.cardNumber,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cardType.toLowerCase() == 'physical'
            ? Image.asset(
              'assets/images/physical_full_card.png',
              width: MediaQuery.of(context).size.width * 0.88,
            )
            : Image.asset(
              'assets/images/virtual_full_card.png',
              width: MediaQuery.of(context).size.width * 0.88,
            ),
        Positioned(
          bottom: 20,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardNickName,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      cardType.toLowerCase() == 'physical'
                          ? Colors.white
                          : Color(0xFF3C4061),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color:
                          cardType.toLowerCase() == 'physical'
                              ? Colors.white
                              : Color(0xFF0B103A),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color:
                          cardType.toLowerCase() == 'physical'
                              ? Colors.white
                              : Color(0xFF0B103A),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color:
                          cardType.toLowerCase() == 'physical'
                              ? Colors.white
                              : Color(0xFF0B103A),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color:
                          cardType.toLowerCase() == 'physical'
                              ? Colors.white
                              : Color(0xFF0B103A),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(width: 8),

                  Text(
                    cardNumber,
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          cardType.toLowerCase() == 'physical'
                              ? Colors.white
                              : Color(0xFF0B103A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
