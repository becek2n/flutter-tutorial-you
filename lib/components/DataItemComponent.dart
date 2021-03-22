import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(title),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(value ?? ''),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
