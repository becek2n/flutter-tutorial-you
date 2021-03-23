import 'package:flutter/material.dart';
import 'package:tutorial_flutter/models/CheckboxModel.dart';

class CheckboxGroupView extends StatefulWidget {
  CheckboxGroupView({Key? key}) : super(key: key);

  @override
  _CheckboxGroupViewState createState() => _CheckboxGroupViewState();
}

class _CheckboxGroupViewState extends State<CheckboxGroupView> {
  List<CheckboxModel> _dropdownAvailability = [];
  bool? _checkAll = false;
  @override
  void initState() {
    _dropdownAvailability.addAll({
      CheckboxModel(id: 1, name: "Monday", selected: false),
      CheckboxModel(id: 2, name: "Tuesday", selected: false),
      CheckboxModel(id: 3, name: "Wednesday", selected: false),
      CheckboxModel(id: 4, name: "Thursday", selected: false),
      CheckboxModel(id: 5, name: "Friday", selected: false),
      CheckboxModel(id: 6, name: "Saturday", selected: false),
      CheckboxModel(id: 7, name: "Sunday", selected: false),
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkbox Group"),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Allow All"),
              ],
            ),
            value: _checkAll, 
            onChanged: (value){
              setState(() {
                _checkAll = value;
                _dropdownAvailability.forEach((element) {
                  element.selected = value;
                });
              });
            }
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _dropdownAvailability.length,
            itemBuilder: (context, index){
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_dropdownAvailability[index].name!),
                    Icon(Icons.plus_one),
                  ],
                ),
                value: _dropdownAvailability[index].selected, 
                onChanged: (value){
                  setState(() {
                    _dropdownAvailability[index].selected = value;

                    final check = _dropdownAvailability.every((element) => element.selected!);

                    _checkAll = check;
                  });
                }
              );
            }
          ),
        ],
      ),
    );
  }
}