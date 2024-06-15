import 'package:test_chat_app/message.dart';
import 'package:test_chat_app/user.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

List<User> listUsers = [
  User(
    name: 'Владимир',
    color: Colors.red,
    messages: [
      Message.divider(message: '27.01.22'),
      Message(
        'Сделай мне кофе, пожалуйста',
        DateTime.now(),
        true,
        false,
      ),
      Message.divider(message: 'Сегодня'),
      Message('Привет', DateTime.now(), true, false),
    ],
  ),
  User(
    name: 'Инна',
    color: Colors.red,
    messages: [
      Message.divider(message: '27.01.22'),
      Message('Добрый день', DateTime.now(), true, false),
      Message.divider(message: 'Сегодня'),
      Message('Все в силе?', DateTime.now(), true, false),
    ],
  )
];

List<Message> allMessages(List<User> userList) {
  List<Message> allMessages = [];
  for (User user in userList) {
    allMessages.addAll(
      user.messages.where(
            (Message message) {
          if (message.isDivider) {
            return false;
          } else {
            return true;
          }
        },
      ),
    );
  }
  return allMessages;
}

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController searchController = TextEditingController();

  List<Message> originalList = allMessages(listUsers);
  List<Message> filteredList = allMessages(listUsers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (text) {
                  filterMessages(searchController.text);
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEDF2F6)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Поиск',
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          Expanded(
              child: (searchController.text.trim().isEmpty)
                  ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: listUsers.length,
                itemBuilder: (context, index) {
                  User user = listUsers[index];

                  String lastMessage = (!user.messages.last.isSender )? user.messages.last.message : "Вы: ${user.messages.last.message } ";
                  Message message = user.messages.last;
                  if ( message.dateSent!.day != DateTime.now().day ) {


                  }

                  {}
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ChatPage(user: user);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: user.color,
                            child: Center(
                              child: Text(
                                user.name[0],
                                style:
                                const TextStyle(color: Colors.white),
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
                              SizedBox(height: 5,),
                              Text(
                                lastMessage,
                                style: const TextStyle(fontSize: 10),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          Spacer(),

                        ],
                      ),
                    ),
                  );
                },
              )
                  : messageSearch(filteredList)),
        ],
      ),
    );
  }

  void filterMessages(
      String search,
      ) {
    if (search == '') {
      setState(() {});
    }
    setState(() {
      filteredList = originalList
          .where((Message message) =>
          message.message.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  Widget messageSearch(List<Message> messageList) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Message message = messageList[index];
        return (!message.isDivider)
            ? ListTile(
          title: Text(
            message.message,
          ),
          trailing: Text(
              "${message.dateSent!.hour.toString()}:${(message.dateSent!.minute.toString().length == 1) ? '0${message.dateSent!.minute}' : message.dateSent!.minute.toString()}"),
        )
            : const SizedBox();
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: messageList.length,
    );
  }
}
