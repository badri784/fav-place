import 'package:fav_place/model/model.dart';
import 'package:flutter/material.dart';

class DeteilScreen extends StatelessWidget {
  const DeteilScreen({super.key, required this.model});
  final Model model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.title.toUpperCase()), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card.outlined(child: ListTile(title: Text(model.title))),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.black,
                      insetPadding: EdgeInsets.zero,
                      child: InteractiveViewer(
                        child: Image.file(model.image, fit: BoxFit.cover),
                      ),
                    ),
                  );
                },

                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.black45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(model.image, fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
