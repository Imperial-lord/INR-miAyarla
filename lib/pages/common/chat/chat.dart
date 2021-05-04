import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:health_bag/functions/validations/userTypeValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/widgets/fullPhoto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat extends StatefulWidget {
  final String id;
  final String peerId;
  final String peerAvatar;
  final String peerName;
  static String classID='chat-screen';

  /* We will need 4 stuff here.
  * 1. Peer Name
  * 2. Peer ID
  * 3. Peer Image
  * 4. My ID
  * */

  Chat(
      {Key key,
      @required this.peerName,
      @required this.id,
      @required this.peerId,
      @required this.peerAvatar})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState(peerName: peerName, id: id, peerId: peerId, peerAvatar: peerAvatar);
}

class _ChatState extends State<Chat> {

  final String id;
  final String peerId;
  final String peerAvatar;
  final String peerName;

  /* We will need 4 stuff here.
  * 1. Peer Name
  * 2. Peer ID
  * 3. Peer Image
  * 4. My ID
  * */

  _ChatState(
      {Key key,
        @required this.peerName,
        @required this.id,
        @required this.peerId,
        @required this.peerAvatar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBack,
            color: MyColors.blueLighter,
          ),
          onPressed: () async {
            bool isDoc = await UserTypeValidation().isUserRegDoctor(id);
            if (!isDoc) {
              FirebaseFirestore fi = FirebaseFirestore.instance;
              fi.collection('Patient Chat Bubbles').doc(id).set({
                'bubble': false,
              });
            } else {
              FirebaseFirestore fi = FirebaseFirestore.instance;
              fi.collection('Doctor Chat Bubbles').doc(peerId).set({
                'bubble': false,
              });
            }
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: MyColors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(peerAvatar),
            ),
            MySpaces.hSmallGapInBetween,
            MyFonts().heading2(peerName, MyColors.blueLighter),
          ],
        ),
      ),
      body: ChatScreen(
        peerName: peerName,
        id: id,
        peerId: peerId,
        peerAvatar: peerAvatar,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String id;
  final String peerId;
  final String peerAvatar;
  final String peerName;

  ChatScreen(
      {Key key,
      @required this.peerName,
      @required this.id,
      @required this.peerId,
      @required this.peerAvatar})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
      id: id, peerId: peerId, peerAvatar: peerAvatar, peerName: peerName);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState(
      {Key key,
      @required this.peerName,
      @required this.id,
      @required this.peerId,
      @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;
  String peerName;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }
    if ((await FirebaseFirestore.instance.collection('users').doc(id).get())
        .exists)
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 75);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    // ensures that each user occupies <= 2 MB in storage
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);
    uploadTask.whenComplete(() async {
      var imageUrl = await ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> onSendMessage(String content, int type) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      bool isDoc = await UserTypeValidation().isUserRegDoctor(id);
      if (!isDoc) {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance
            .collection('Doctor Chat Bubbles')
            .doc(id)
            .set({'bubble': true});
      } else {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance
            .collection('Patient Chat Bubbles')
            .doc(peerId)
            .set({'bubble': true});
      }

      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('Messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // don't send anything if blank
      // no need to notify user -- kinda annoying!
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
              // Text
              ? Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Linkify(
                    onOpen: (link) async => await canLaunch(link.url)
                        ? await launch(link.url)
                        : throw 'Could not launch ${link.url}',
                    text: document.data()['content'],
                    style: TextStyle(
                        fontFamily: 'lato',
                        fontSize: 15,
                        color: MyColors.white),
                    linkStyle: TextStyle(
                        fontFamily: 'lato',
                        fontSize: 15,
                        color: MyColors.white),
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MyColors.blueLighter,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 10.0 : 5.0,
                      right: 10.0),
                )
              : document.data()['type'] == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: MyColors.backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document.data()['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullPhoto(
                                      url: document.data()['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: Image.asset(
                        'images/${document.data()['content']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: peerAvatar,
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document.data()['type'] == 0
                    ? Container(
                        constraints: BoxConstraints(maxWidth: 250),
                        // child: MyFonts()
                        //     .body(document.data()['content'], MyColors.black),
                        child: Linkify(
                          onOpen: (link) async => await canLaunch(link.url)
                              ? await launch(link.url)
                              : throw 'Could not launch ${link.url}',
                          text: document.data()['content'],
                          style: TextStyle(
                              fontFamily: 'lato',
                              fontSize: 15,
                              color: MyColors.black),
                          linkStyle: TextStyle(
                              fontFamily: 'lato',
                              fontSize: 15,
                              color: MyColors.black),
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: MyColors.backgroundColor,
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document.data()['type'] == 1
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: MyColors.backgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document.data()['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document.data()['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: Image.asset(
                              'images/${document.data()['content']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.data()['timestamp']))),
                      style: TextStyle(
                          color: MyColors.gray,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() async {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      if ((await FirebaseFirestore.instance.collection('users').doc(id).get())
          .exists)
        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({'chattingWith': null});

      bool isDoc = await UserTypeValidation().isUserRegDoctor(id);
      if (!isDoc) {
        FirebaseFirestore fi = FirebaseFirestore.instance;
        fi.collection('Patient Chat Bubbles').doc(id).set({
          'bubble': false,
        });
      } else {
        FirebaseFirestore fi = FirebaseFirestore.instance;
        fi.collection('Doctor Chat Bubbles').doc(peerId).set({
          'bubble': false,
        });
      }
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Input content
                buildInput(),
              ],
            ),

            // Loading
            buildLoading()
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.blueLighter),
                ),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Button send image
          IconButton(
            icon: Icon(EvaIcons.image),
            onPressed: getImage,
            color: MyColors.blueLighter,
          ),
          MySpaces.hSmallestGapInBetween,
          // Edit text
          Flexible(
            child: CupertinoTextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text, 0);
              },
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: MyColors.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              expands: true,
              maxLines: null,
              minLines: null,
              style: TextStyle(
                  fontFamily: 'lato', color: MyColors.black, fontSize: 16),
              controller: textEditingController,
              placeholder: 'Write a message',
              focusNode: focusNode,
            ),
          ),
          MySpaces.hSmallestGapInBetween,
          // Button send message
          IconButton(
            icon: Icon(Icons.send_rounded),
            onPressed: () => onSendMessage(textEditingController.text, 0),
            color: MyColors.blueLighter,
          ),
        ],
      ),
      constraints: BoxConstraints(maxHeight: 150),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Messages')
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(_limit)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  listMessage.addAll(snapshot.data.docs);
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}
