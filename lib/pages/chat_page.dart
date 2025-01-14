/*
import 'dart:developer';
import 'package:chat_app/components/text_component.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:chat_app/components/bubble_special_three_component.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/request_microphone_permission_helper.dart';
import 'package:chat_app/helper/snack_bar_helper.dart';
import 'package:snappable_thanos/snappable_thanos.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String chatId = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Map<String, GlobalKey<SnappableState>> snappableKeys =
      {}; // Store unique keys for each message
  FlutterSoundRecorder?
      recorder; //record(click on icon to start and stop record)
  bool isRecording = false; //to know if the record still start or stop
  String?
      filePath; //path for voice message,when you stopRecording you can take it
  String?
      selectedMessageId; //id for each message(to delete selectMessage or unSelect selectMessage)
  Set<String> selectedMessageIds =
      {}; //many ids selecteMessage not single id id and Set no List because no need same element
  FlutterSoundPlayer?
      player; //to start listen on Audio(from view),start,closeAudio
  String? currentlyPlayingUrl; //url audio to audio is working now
  bool isPlaying = false; //to know if the voiceMessage still play or close
  late String theAccount; //email
  TextEditingController controller = TextEditingController(); //controll on text
  ScrollController scrollController = ScrollController(); //controll on scroll

  @override
  void initState() {
    super.initState();
    theAccount = BlocProvider.of<AuthCubit>(context).email!;
    initializeRecorder();
    initializePlayer();
  } //initialize to start record,start playAudio and get on email

  Future<void> initializePlayer() async {
    player = FlutterSoundPlayer();
    await player!.openPlayer();
  } // Open the player

  @override
  void dispose() {
    recorder?.closeRecorder();
    player?.closePlayer();
    super.dispose();
  } //when you leave ChatView so will dispose from closeRecord and closePlayer, to ensure no resource still working

  Future<void> playAudio(String url) async {
    if (player == null) {
      showMessageToUser(
        context: context,
        text: 'Audio player is not initialized.',
      );
      return;
    }

    if (isPlaying && currentlyPlayingUrl == url) {
      //if the audio playing(isPlaying == true)&& url for same audio(i talk on it)so pause audio
      await player!.pausePlayer();
      setState(
        () {
          isPlaying = false;
        },
      );
    } else if (currentlyPlayingUrl == url) {
      //so same audio but isPlaying == false(audio pause)so resume audio
      await player!.resumePlayer();
      setState(
        () {
          isPlaying = true;
        },
      );
    } else {
      //when the audio is finish you should stopPlayer,so now you can play another audio or play same audio again or i heard on 5 seconds for this audio from 10 seconds so i want to play another audio
      await player!.stopPlayer();

      // Play the new audio file
      try {
        await player!.startPlayer(
          fromURI: url,
          codec: Codec.aacADTS,
          whenFinished: () {
            setState(
              () {
                isPlaying = false;
                currentlyPlayingUrl = null;
              },
            );
          },
        );
        setState(
          () {
            isPlaying = true;
            currentlyPlayingUrl = url; // Update the currently playing audio URL
          },
        ); //sure change value in two variables,sure whenFinished:...,but you must change values(to work not no work) in two variables, so now when you want to start or restart audio the two variables have a new values and the values enable you to work without any late if delete this code(change values for two variables)
      } catch (e) {
        showMessageToUser(
          context: context,
          text: 'Failed to play audio: ${e.toString()}',
        );
      }
    }
  }

  Future<void> initializeRecorder() async {
    recorder = FlutterSoundRecorder();
    await recorder!.openRecorder();
    bool hasPermission = await requestMicrophonePermission(
      context,
    );
    if (!hasPermission) {
      showMessageToUser(
        context: context,
        text: 'microphone permission is required to send voice message',
      );
    }
  }

  Future<void> startRecording() async {
    bool hasPermission = await requestMicrophonePermission(
      context,
    );
    if (!hasPermission) {
      showMessageToUser(
        context: context,
        text:
            'again Microphone Permission Is Required To Send The Voice Message',
      );
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    filePath =
        '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    log(
      'File Path Exists Or No So ${File(
        filePath!,
      ).existsSync()}',
    ); //File(filePath!).existsSync() to check if filePath is exist(will return true) or no(will return false)
    try {
      await recorder!.startRecorder(
        toFile: filePath,
        codec: Codec.aacADTS,
      );
      setState(
        () {
          isRecording = true;
        },
      );
    } catch (e) {
      showMessageToUser(
        context: context,
        text: 'Failed To Start Recording: ${e.toString()}',
      );
    }
  }

  Future<void> stopRecording() async {
    if (recorder == null) return;
    await recorder!.stopRecorder();
    setState(
      () {
        isRecording = false;
      },
    );
    if (filePath != null) {
      context.read<ChatCubit>().sendAndGetAudioMessage(
            filePath!,
            context,
          );
    }
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      var localTimestamp = DateTime.now();
      FirebaseFirestore.instance
          .collection(
        kMessagesCollection,
      )
          .add(
        {
          kMessageField: controller.text,
          kTimeStampField: localTimestamp,
          kAccountField: theAccount,
        },
      ).then(
        (_) {
          controller.clear();
          scrollController.animateTo(
            0,
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeIn,
          );
        },
      ).catchError(
        (
          error,
        ) {
          showMessageToUser(
            context: context,
            text: error.toString(),
          );
        },
      );
    }
  }

  void deleteSelectedMessages() {
    //start to apply the snap effect
    for (String messageId in selectedMessageIds) {
      final snappableState = snappableKeys[messageId]
          ?.currentState; //currentState reference to connect state with GlobalKey
      //trigger the snap effect for the selected message if there is snappableState and sanppableState dosen't go for now(doesn't delete)
      if (snappableState != null && !snappableState.isGone) {
        snappableState.snap();
      } else {
        snappableState?.reset();
      }
    }
    // Delay the deletion from Firestore to allow snap animation to complete
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () {
        for (String messageId in selectedMessageIds) {
          FirebaseFirestore.instance
              .collection(
                kMessagesCollection,
              )
              .doc(
                messageId,
              )
              .delete()
              .catchError(
            (
              error,
            ) {
              showMessageToUser(
                context: context,
                text: 'Error deleting message: $error',
              );
            },
          );
        }
        //clear the selectedMessagesIds after deletion
        setState(
          () {
            selectedMessageIds.clear();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(
            0xff1F303A,
          ),
          appBar: AppBar(
            backgroundColor: kWeakBlueColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 57,
                  child: Image.asset(
                    kScholarChatImage,
                  ),
                ),
                TextComponent(
                  text: 'Chat',
                  color: kWhiteColor,
                  fontSize: 25,
                ),
              ],
            ),
            actions: [
              if (selectedMessageIds
                  .isNotEmpty) // Show delete icon if messages are selected
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: kWhiteColor,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context)
                        .deleteMessageAndVoiceMessage(
                      selectedMessageIds: selectedMessageIds,
                      snappableKeys: snappableKeys,
                      context: context,
                    ); // Call function to delete all selected messages
                  },
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount:
                      BlocProvider.of<ChatCubit>(context).getMessages.length,
                  itemBuilder: (context, index) {
                    final listElement =
                        context.read<ChatCubit>().getMessages[index];
                    final messageId = listElement.id;

                    // GestureDetector to handle long press for selecting multiple messages
                    return GestureDetector(
                      onLongPress: () {
                        setState(
                          () {
                            //if messageId found in selectedMessagesIds so delete this messageId(message you click on it onlongPress) else add this messageId to selectedMessagesIds
                            if (selectedMessageIds.contains(
                              messageId,
                            )) {
                              selectedMessageIds.remove(
                                messageId,
                              );
                            } else {
                              selectedMessageIds.add(
                                messageId,
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        color: selectedMessageIds.contains(
                          messageId,
                        )
                            ? Colors.grey.withValues(
                                alpha: 0.3,
                              ) // Highlight selected messages
                            : Colors.transparent,
                        child: Snappable(
                          key: snappableKeys[messageId],
                          snapOnTap: true,
                          child: listElement.audioUrl != null &&
                                  listElement.audioUrl!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 11,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        listElement.recieveTheAccount ==
                                                theAccount
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Play Audio Logic
                                          playAudio(
                                            listElement.audioUrl!,
                                          );
                                        },
                                        child: Icon(
                                          currentlyPlayingUrl ==
                                                      listElement.audioUrl &&
                                                  isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color:
                                              listElement.recieveTheAccount ==
                                                      theAccount
                                                  ? kPinkAccentColor
                                                  : kDeepPurpleAccentColor,
                                          size: 32,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextComponent(
                                        text:
                                            '${listElement.recieveTheAccount.split('@').first} voice message  ',
                                        color: listElement.recieveTheAccount ==
                                                theAccount
                                            ? kPinkAccentColor
                                            : kDeepPurpleAccentColor,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                )
                              : BubbleSpecialThreeComponent(
                                  text:
                                      '${listElement.recieveTheAccount.split('@').first}: ${listElement.message}',
                                  audioUrl: listElement.audioUrl,
                                  color: listElement.recieveTheAccount ==
                                          theAccount
                                      ? kPinkAccentColor
                                      : kDeepPurpleAccentColor,
                                  isSender: listElement.recieveTheAccount ==
                                      theAccount,
                                  recieveDateTime: listElement.assignDateTime,
                                ),
                          onSnapped: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Input & Send Buttons (unchanged)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 9,
                  top: 5,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          context.read<ChatCubit>().sendMessage(
                                scrollController: scrollController,
                                textController: controller,
                                context: context,
                                theAccount: theAccount,
                              );
                        },
                        style: TextStyle(
                          color: kWhiteColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type Message',
                          hintStyle: TextStyle(
                            color: kWhiteColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: BorderSide(
                              color: kWhiteColor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: kWhiteColor,
                              size: 28,
                            ),
                            onPressed: () {
                              BlocProvider.of<ChatCubit>(context).sendMessage(
                                scrollController: scrollController,
                                textController: controller,
                                context: context,
                                theAccount: theAccount,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isRecording ? Icons.stop : Icons.mic,
                        color: kWhiteColor,
                        size: 32,
                      ),
                      onPressed: () async {
                        if (isRecording) {
                          await stopRecording();
                        } else {
                          await startRecording();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/
/*
explain all variables and methods(1: what is this, 2: why i use it, 3: what can it do)
* Variables:
1: snappableKeys:
Type: Map<String, GlobalKey<SnappableState>>
Purpose: Stores unique keys for each message, allowing individual messages to have their snap animation applied when they are deleted.
Usage: Used in the deleteSelectedMessages method to trigger animations.

2: recorder:
Type: FlutterSoundRecorder?
Purpose: Manages the recording of audio messages.
Usage: Initialized in initializeRecorder() and used in startRecording() and stopRecording().

3: isRecording:
Type: bool
Purpose: Tracks whether audio recording is currently active.
Usage: Updated in startRecording() and stopRecording().

4: filePath:
Type: String?
Purpose: Holds the file path of the recorded audio message.
Usage: Set during startRecording() and used in stopRecording() to send the audio file.

5: selectedMessageId:
Type: String?
Purpose: Tracks the ID of a currently selected message (for future use).
Usage: Placeholder; not used in the provided code snippet.

6: player:
Type: FlutterSoundPlayer?
Purpose: Manages audio playback for voice messages.
Usage: Initialized in initializePlayer() and used in playAudio().

7: currentlyPlayingUrl:
Type: String?
Purpose: Tracks the URL of the audio currently being played.
Usage: Checked and updated in playAudio().

8: isPlaying:
Type: bool
Purpose: Indicates if an audio file is currently playing.
Usage: Updated in playAudio().

9: theAccount:
Type: String?
Purpose: Stores the email of the authenticated user.
Usage: Retrieved in initState() from the AuthCubit.

10: controller:
Type: TextEditingController
Purpose: Handles input in the message text field.
Usage: Used in sendMessage() to retrieve and clear the input.

11: scrollController:
Type: ScrollController
Purpose: Manages scrolling behavior for the chat.
Usage: Used in sendMessage() to auto-scroll after sending a message.

* Methods:
1: initState():
Purpose: Initializes variables and resources when the widget is first created.
What It Does:
Retrieves the authenticated user's email using AuthCubit.
Calls initializeRecorder() and initializePlayer() to prepare the recorder and player.

2: dispose():
Purpose: Cleans up resources when the widget is destroyed.
What It Does:
Closes the recorder and player to release system resources.

3: initializeRecorder():
Purpose: Prepares the audio recorder for use.
What It Does:
Opens the recorder.
Requests microphone permission. If denied, shows an error message.

4: startRecording():
Purpose: Starts recording an audio message.
What It Does:
Checks microphone permissions.
Generates a file path for the recording.
Starts the recorder and updates the UI state.

5: stopRecording():
Purpose: Stops the audio recording.
What It Does:
Stops the recorder.
If a valid file path exists, calls sendAudioMessage() to upload the recording.

6: initializePlayer():
Purpose: Prepares the audio player for use.
What It Does:
Initializes the player by opening it.

7: playAudio(String url):
Purpose: Handles playback of audio messages.
What It Does:
If already playing the requested URL, pauses playback.
If paused, resumes playback.
If a different URL is requested, stops current playback and plays the new URL.

8: sendMessage():
Purpose: Sends a text message.
What It Does:
Adds the message, timestamp, and user email to Firestore.
Clears the text field and auto-scrolls to the latest message.

9: deleteSelectedMessages():
Purpose: Deletes selected messages from Firestore with a snap animation.
What It Does:
Triggers the snap animation for each selected message.
Delays the deletion until the animation completes.
Removes messages from Firestore and clears the selection.
*/
