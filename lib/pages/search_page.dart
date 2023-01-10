import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _fromKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
      final form = _fromKey.currentState;

      if (form != null || form!.validate()) {
        form.save();
        Navigator.pop(context, _city!.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Form(
        key: _fromKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
            TextFormField(
              autofocus: true,
              style: TextStyle(fontSize: 30),
              decoration: InputDecoration(
                labelText: '도시 이름',
                hintText: '도시 이름을 입력하세요',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return '입력하세요';
                } else {
                  return null;
                }
              },
              onSaved: (String? newValue) {
                _city = newValue;
                print(_city);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _submit(),
              child: Text(
                '입력',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
