import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/models/form_data.dart';

import '../widgets/form_result.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({Key? key}) : super(key: key);

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

/*Form needs a key, Keys are used in Flutter to uniquely identify widgets,
 and they contain some additional information. In this case, global key
 used for storing form's state. Global keys are unique across the entire app
 Form always go with statfulwidget.
 */
class _CreateArticleState extends State<CreateArticle> {
  /*FormState Objects can be used to save reset, and validate every form field
    that is inside the correspondent form.
   */
  final _formKey = GlobalKey<FormState>();
  FormData formData = FormData();

  String? validateEmail(String? value) {
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern as String);
    if (!regex.hasMatch(value!))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Article')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Title' : null,
                onSaved: (value) => formData.title = value,
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text('Is Breaking News'),
                value: formData.isBreaking!,
                onChanged: (bool value) =>
                    setState(() => formData.isBreaking = value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image Url'),
                validator: (value) => !Uri.parse(value!).isAbsolute
                    ? 'Please enter valid url'
                    : null,
                onSaved: (value) => formData.imageUrl = value,
              ),
              TextFormField(
                maxLength: 3,
                decoration: const InputDecoration(labelText: 'Content'),
                validator: (value) => value!.isEmpty || value.length > 3
                    ? 'Content too short'
                    : null,
                onSaved: (value) => formData.content = value,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text('Category'),
              ),
              Column(
                children: [
                  /*grouopValue, assign both radio buttons to the same group value variable,
                    this links the two buttons together, so can only select one of them
                   */
                  RadioListTile<int>(
                    title: const Text('Sport'),
                    value: 1,
                    groupValue: formData.category,
                    onChanged: (value) {
                      setState(() {
                        formData.category = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Enterainment'),
                    value: 2,
                    groupValue: formData.category,
                    onChanged: (value) {
                      setState(() {
                        formData.category = value;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your Email'),
                validator: validateEmail,
                onSaved: (value) => formData.email = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState!;
                    if (form.validate()) {
                      form.save();
                      form.reset();

                      _showResultDialog(context);
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showResultDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: FormResult(data: formData),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Done'),
            )
          ],
        );
      },
    ).then((value) {
      setState(() {
        formData.isBreaking = false;
        formData.category = null;
      });
    });
  }
}
