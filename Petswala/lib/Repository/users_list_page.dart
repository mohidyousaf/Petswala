import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/spacingAndBorders.dart';
import 'channel_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChatNavigator extends StatelessWidget {
  final StreamChatClient client;
  const ChatNavigator({ Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouteSettings passedSettings = ModalRoute.of(context).settings;
    return StreamChat(
      client: client,
      streamChatThemeData: StreamChatThemeData(
      ownMessageTheme: StreamMessageThemeData(
      messageTextStyle: TextStyle(
          fontWeight:FontWeight.bold,
          color: AppColor.primary, fontSize: 20),
      avatarTheme: StreamAvatarThemeData(
          constraints: BoxConstraints(maxHeight:80, maxWidth:80),
          borderRadius: BorderRadius.circular(20)))),
                                                  
      child: Navigator(
          initialRoute: '/',
           onGenerateRoute: (settings) {
              Widget page;
              switch (settings.name){
                case '/': page = UsersListPage();break;
                case '/channel': page = ChannelPage();break;
    
              }
              return CupertinoPageRoute(builder: (context) => page, 
                    settings: passedSettings.arguments != null ? passedSettings:settings);
            },
          ),
    );
  }
}

class UsersListPage extends StatefulWidget {
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  // List<User> _usersList = [];
  // bool _loadingData = true;
  ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: StreamChannelListView(
  //       filter: {
  //         'members': {
  //           '\$in': [StreamChat.of(context).user.id],
  //         }
  //       },
  //       sort: [SortOption('last_message_at')],
  //       pagination: PaginationParams(
  //         limit: 20,
  //       ),
  //       channelWidget: ChannelPage(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Logo(color: AppColor.primary),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: AppBorderRadius.all_20),
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColor.white,
                    size: 30,
                  )),
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
      body: SafeArea(
          // ignore: deprecated_member_use
          child: ChannelsBloc(
            // ignore: deprecated_member_use
            child: ChannelListView(
              padding: EdgeInsets.all(16),
              filter: Filter.in_('members',[StreamChat.of(context).currentUser.id]),
              sort: const [SortOption('last_message_at')],
              limit: 20,
              onChannelTap: (Channel channel, Widget channelWidget){
                Navigator.of(context).pushNamed('/channel', arguments: channel);
              },
            ),
          ),
        ),
    );
  }

  // _fetchUsers() async {
  //   setState(() {
  //     _loadingData = true;
  //   });

  //   StreamChat.of(context).client.queryUsers(
  //       filter: Filter.notEqual('id', StreamChat.of(context).currentUser.id),
  //       sort: [SortOption('last_message_at')]).then((value) {
  //     setState(() {
  //       if (value.users.length > 0) {
  //         _usersList = value.users.where((element) {
  //           return element.id != StreamChat.of(context).currentUser.id;
  //         }).toList();
  //       }
  //       _loadingData = false;
  //     });
  //   }).catchError((error) {
  //     setState(() {
  //       _loadingData = false;
  //     });
  //     print(error);
  //     // Could not fetch users
  //   });
  // }

  // void _navigateToChannel(int index, context) async {
  //   var client = StreamChat.of(context).client;
  //   var currentUser = StreamChat.of(context).currentUser;

  //   Channel channel;

  //   await client
  //       .channel("messaging", extraData: {
  //         "members": [currentUser.id, _usersList[index].id]
  //       })
  //       .create()
  //       .then((response) {
  //         channel = Channel.fromState(client, response);
  //         channel.watch();
  //       })
  //       .catchError((error) {
  //         print(error);
  //       });

  //   if (channel != null) {
  //     print('channel is created');
  //     Navigator.of(context).pushNamed('/channel', arguments: channel);
  //   } else {
  //     // Could not find a channel;
  //   }
  // }
}
