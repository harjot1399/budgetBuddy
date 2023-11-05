import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'commonRowUI.dart';
import 'homePage.dart';

class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  TextEditingController categoryName = TextEditingController();
  List <String> transcations = [];

  final Map<IconData, String> expenseCategoryIconsWithNames = {
    Icons.shopping_cart: 'Groceries',
    Icons.directions_car: 'Transportation',
    Icons.local_dining: 'Dining Out',
    Icons.lightbulb_outline: 'Utilities',
    Icons.home: 'Rent/Mortgage',
    Icons.local_hospital: 'Healthcare',
    Icons.videogame_asset: 'Entertainment',
    Icons.shopping_bag: 'Shopping',
    Icons.school: 'Education',
    Icons.airplanemode_active: 'Travel',
    Icons.card_giftcard: 'Gifts',
    Icons.favorite: 'Charity/Donations',
    Icons.shield: 'Insurance',
    Icons.account_balance: 'Savings',
    Icons.question_answer: 'Other',
    Icons.local_gas_station: 'Fuel',
    Icons.wifi: 'Internet',
    Icons.phone: 'Phone',
    Icons.tv: 'Cable/TV',
    Icons.child_friendly: 'Childcare',
    Icons.pets: 'Pets',
    Icons.attach_money: 'Loan',
    Icons.book: 'Books',
    Icons.fitness_center: 'Gym/Fitness',
    Icons.money_off: 'Taxes',
    Icons.palette: 'Hobbies',
    Icons.devices: 'Electronics',
    Icons.weekend: 'Furniture',
    Icons.music_note: 'Music',
    Icons.beach_access: 'Vacation',
    Icons.credit_card: 'Credit Card Payment',
    Icons.show_chart: 'Investments',
    Icons.restaurant : 'Restaurant'
  };

  IconData? selectedIcon;

  Future<void> _openIconPickerDialog() async {
    IconData? newIcon = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select an Icon'),
          children: [
            // Replace this list with the icons you want to display
            for (var key in expenseCategoryIconsWithNames.keys)
              ListTile(
                leading: Icon(key),
                title: Text(expenseCategoryIconsWithNames[key]!),
                onTap: () {
                  Navigator.of(context).pop(key);
                },
              ),
          ],
        );
      },
    );

    if (newIcon != null) {
      setState(() {
        selectedIcon = newIcon;
      });
    }
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future<void> _openColorPickerDailog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF9F6EE),
          body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(intialIndex: 1,),
                        ),
                      );
                    }, icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFFf89361),)),

                    const Padding(
                      padding: EdgeInsets.only(left: 75),
                      child: Text('New Category',style: TextStyle(fontSize: 22, color: Color(0xFFf89361)),),
                    ),



                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 250,
                  width: 400,

                  child: Card(
                      color: const Color(0xFF114945),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          commonRowUI(vary: TextField(
                            controller: categoryName,
                          ), varyIcon: Icons.category, text: 'Name'),
                          const SizedBox(height: 15.0,),
                          commonRowUI(vary: ElevatedButton(onPressed: _openIconPickerDialog, child: Row(
                            children: [
                              Icon(selectedIcon ?? Icons.category), // Display the selected icon or a default one
                              const SizedBox(width: 10),
                              Text(selectedIcon != null
                                  ? expenseCategoryIconsWithNames[selectedIcon!] ?? 'Unknown'
                                  : 'Select Category'),
                            ],
                          ),), varyIcon: Icons.image, text: 'Appearance'),
                          const SizedBox(height: 15,),
                           commonRowUI(vary: ElevatedButton(onPressed: _openColorPickerDailog, child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: pickerColor,
                              ), // Display the selected icon or a default one
                              const SizedBox(width: 10),
                              Text('Select a Color'),
                            ],
                          ),), varyIcon: Icons.border_color, text: 'Color')


                        ],
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ElevatedButton(onPressed: () {

                    addCategorytoDB(selectedIcon.toString(), categoryName.text, pickerColor.toString(),context, transcations);
                  },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<
                          Color>(const Color(0xFF114945)),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(370.0, 60.0),
                      ),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text('Add', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),),
                ),
              ]
          )
      ),
    );
  }
}
