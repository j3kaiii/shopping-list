import 'package:flutter/material.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';

class CreateItemScreenArgs {
  final ItemType type;
  final String? ownerList;

  const CreateItemScreenArgs(this.type, {this.ownerList});
}

class CreateItemScreen extends StatefulWidget {
  final CreateItemScreenArgs args;
  const CreateItemScreen(this.args, {super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final _itemNameController = TextEditingController();

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: 'Add New Item',
      showBackButton: true,
      bottomButtonText: 'Add to Database',
      onBottomButtonPressed: () {
        // TODO
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'What do you need today?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add an item to your digital pantry.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'ITEM NAME',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3B3BFF),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            // Text field
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: 'e.g. Oat Milk',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3B3BFF)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3B3BFF), width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ItemType {
  list,
  product,
}
