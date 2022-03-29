import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final String? title;
  final String? value;

  const DetailItem({Key? key, this.title, this.value}) : super(key: key);

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
                    child: Text(title!, style: TextStyle(fontSize: 20)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(value ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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

class DetailItemEditComponent extends StatelessWidget {
  final String title;
  final Widget widget;

  const DetailItemEditComponent({Key? key, required this.title, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(title,style: TextStyle(fontSize: 20)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: widget,
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