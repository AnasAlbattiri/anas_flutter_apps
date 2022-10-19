import 'dart:ui';

import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://scontent.famm11-1.fna.fbcdn.net/v/t39.30808-6/272899152_2265457783597339_4960631699693255242_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGM-HBOEfXS6ExHuUDplvpbjoansiIIxauOhqeyIgjFq6eHN53n6d9nFfrlZhDTF9reO2Gsz1zFaL2X9S4_32uq&_nc_ohc=pkagbDzoRgYAX-u-PWz&_nc_ht=scontent.famm11-1.fna&oh=00_AT9KizsJuDUYnQbACM_Ktrdd5vYO0UynyoKSkSkgUmdJLA&oe=629D4EA2'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                    color: Colors.grey[300],
                  ),
                  padding: EdgeInsets.all(
                    5.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Search',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated
                    (
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (index, context) => buildStroyItem(),
                      separatorBuilder: (index, cotext) => SizedBox(
                        width: 15.0,
                      ),
                      itemCount: 7
                    ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemBuilder: (index, context) => buildChatItem(),
                    separatorBuilder: (index, context) => SizedBox(
                      height: 20.0,
                    ),
                    itemCount: 9,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  // 1. build item
  // 2. build list
  // 3. add item to list
  Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/34492145?v=4'),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 3.0,
              end: 3.0,
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children:
              [
                Expanded(
                  child: Text(
                    'hello my name is abdullah ahmed hello my name is abdullah ahmed',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text(
                  '02:00 pm',
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStroyItem() => Container(
    width: 60.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34492145?v=4'),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 3.0,
                end: 3.0,
              ),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          'Abdullah Mansour Ali Mansour',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  // arrow function

}