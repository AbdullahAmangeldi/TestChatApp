import 'package:flutter/material.dart';
import 'package:test_chat_app/user.dart';

List<User> listUsers = [
  User(
    name: 'Владимир',
    color: Colors.red,

  ),
  User(
    name: 'Владимир',
    color: Colors.red,

  )
];
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
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
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                User user = listUsers[index];
            
            
            
            
            
                return InkWell(
            
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
            
                          ],
                        ),
                        Spacer(),
            
                      ],
                    ),
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
