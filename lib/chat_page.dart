import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_chat_app/user.dart';

import 'chats_page.dart';
import 'message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.user});
  final User user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  void _sendMessage() {
    if (textEditingController.text.isNotEmpty || _selectedImage != null) {
      setState(() {
        sendMessage(
          widget.user.name,
          textEditingController.text,
          _selectedImage,
        );
        textEditingController.clear();
        _selectedImage = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const ChatsPage();
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 5.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: user.color,
              child: Center(
                child: Text(
                  user.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const Text(
                  'В сети',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListView.separated(
                itemCount: user.messages.length,
                itemBuilder: (context, index) {
                  Message message = user.messages[index];
                  if (message.isDivider) {
                    return Column(
                      children: [Text(message.message), const Divider()],
                    );
                  }
                  return Row(
                    children: [
                      (message.isSender) ? const Spacer() : const SizedBox(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color:
                                (message.isSender) ? Colors.green : Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message.imageFile != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Image.file(
                                  message.imageFile!,
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            if (message.message.isNotEmpty)
                              Text(
                                message.message,
                              ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "${message.dateSent!.hour.toString()}:${(message.dateSent!.minute.toString().length == 1) ? '0${message.dateSent!.minute}' : message.dateSent!.minute.toString()}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                const SizedBox(width: 5),
                                if (message.isSender)
                                  Icon(
                                    (message.isRead)
                                        ? Icons.done_all
                                        : Icons.check,
                                    size: 11,
                                  ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
              ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              IconButton(
                onPressed: _pickImage,
                icon: const Icon(Icons.attach_file),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Сообщение',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEDF2F6)),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.mic),
              ),
              IconButton(
                onPressed: _sendMessage,
                //     () {
                //   setState(() {
                //     sendMessage(user.name, textEditingController.text);
                //     print(textEditingController.text);
                //     textEditingController.clear();
                //     for (Message message in user.messages) {
                //       print(message.message);
                //     }
                //   });
                // },
                icon: const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void sendMessage(String userName, String messageText, [File? imageFile]) {
  try {
    User user = listUsers.firstWhere((user) => user.name == userName);

    Message newMessage = Message(
      messageText,
      DateTime.now(),
      false,
      true,
      imageFile: imageFile,

    );

    user.messages.add(newMessage);
  } catch (e) {}
}
