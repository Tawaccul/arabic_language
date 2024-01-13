import 'package:flutter/material.dart';
import 'package:flutter_quran_words/words/words_db.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with TickerProviderStateMixin {
 bool isDropdownOpen = false;
 final List<String> _categories = Database().categories.map((e) => e.name).toList();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 89, 218, 158),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(6, 109, 109, 109).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_categories[0]}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RotationTransition(
                      turns: Tween<double>(begin:  0.0 , end: isDropdownOpen ? 0.25 : 0.0 )
                          .animate(
                            CurvedAnimation(
                              parent: AnimationController(
                                vsync: this,
                                duration: Duration(milliseconds: 200),
                              )..forward(),
                              curve: Curves.linear,
                            ),
                          ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isDropdownOpen)
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item 1',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Item 2',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Item 3',
                        style: TextStyle(color: Colors.white, fontSize: 20),
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