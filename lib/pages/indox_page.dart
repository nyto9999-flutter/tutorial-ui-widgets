import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/models/message.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Image.asset(
          'assets/images/logo_dark.png',
          width: 180,
        ),
        //For only HomePage iOS
        trailing: IconButton(
          icon: const Icon(CupertinoIcons.add_circled),
          onPressed: () {},
        ),
        //end
      ),
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              leading: const CircleAvatar(),
              title: Text(messages[index].author),
              subtitle: Text(
                messages[index].content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(messages[index].sentTime),
            );
          }),
    );
  }
}
