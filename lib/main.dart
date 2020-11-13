import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:volume/volume.dart';
import 'dart:async';
import 'dart:io' show Platform;


final FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(MaterialApp(
    home: homepage(),
    debugShowCheckedModeBanner: false,
  ));
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text(
                "Yellow Class",
                style: TextStyle(
                    fontFamily: 'CustomFamilyName',
                    fontSize: 45,
                    color: Colors.amberAccent
                ),
              ),
          ),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.amberAccent,width: 1)
                      ),
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                        onPressed: (){
                        Navigator.push(context, MaterialPageRoute
                          (builder: (context){
                            return login();
                        }));
                        },
                      child: Text("LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.amberAccent
                      ),),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.amberAccent,width: 1)
                    ),
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 55,vertical: 15),
                    onPressed: (){},
                    child: Text("SIGNUP",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.amberAccent
                      ),),
                  )
                ,]
            ),
          )
        ],

      ),
    );
  }
}

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final user = TextEditingController();
  final pass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black87,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 100, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontFamily: 'CustomFamilyName',
                          fontSize: 40,
                          color: Colors.amberAccent
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
                    child: TextField(
                      controller: user,
                      style: TextStyle(
                        fontSize: 20
                      ),
                      cursorColor: Colors.amberAccent,
                      decoration: InputDecoration(
                        hintText: "Username",
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.mail,
                        color: Colors.amberAccent,),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)

                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 40),
                    child: TextField(
                      controller: pass,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      cursorColor: Colors.amberAccent,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.lock,
                          color: Colors.amberAccent,),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)

                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.amberAccent,width: 1)
                      ),
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 55,vertical: 15),
                      onPressed: () async{
                      int flag=1;
                        if (Platform.isIOS) {
                        // iOS-specific code
                          if(user.text=='ios' && pass.text=='123')
                            {
                              flag=0;
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return playvid();
                              }));
                            }
                        }
                        //final FirebaseUser user = await auth.currentUser();
                        FirebaseUser firebaseuser = null;
                        try {
                                firebaseuser = (await auth
                              .signInWithEmailAndPassword(
                            email: user.text,
                            password: pass.text,
                          )).user;
                        }
                        catch(e){
                          setState(() {
                            if(flag==1)
                              {
                                Fluttertoast.showToast(
                                    msg: 'Incorrect username or password',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.amberAccent);
                              }
                                   }
                            );
                        }
                        if (firebaseuser != null) {
                          setState(() {
                            Fluttertoast.showToast(
                                msg: 'Logged in!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.black87,
                                textColor: Colors.amberAccent);
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return playvid();
                            }));
                          });
                        }
                        }
                        ,
                      child: Text("SIGN IN",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.amberAccent
                        ),),
                    ),
                  )
                ],
              ),
            )
          ],

        ),
      ),
    );;
  }
}

class playvid extends StatefulWidget {
  @override
  _playvidState createState() => _playvidState();
}

class _playvidState extends State<playvid> {

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
              child: IconButton(
                  icon: Icon(Icons.play_circle_fill),
                  iconSize: 150,
                  color: Colors.amberAccent,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return videorunning();
                    }));
                  }),
            ),
              Text(
                'PLAY',
                style: TextStyle(
                    fontSize: 25
                    ,
                    color: Colors.amberAccent,
                    letterSpacing: 2
                ),
              ),
           ]
          )
        ],
      ),
    );
  }
}

class videorunning extends StatefulWidget {
  @override
  _videorunningState createState() => _videorunningState();
}

class _videorunningState extends State<videorunning> {

  Timer _timer;
  void startTimer(int _start) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start == 3) {
            _visible=false;
            timer.cancel();
          } else {
            _start = _start + 1;
          }
        },
      ),
    );
  }

  AudioManager audioManager;
  VideoPlayerController controller;
  Future<void> f;
  int maxVol, currentVol;
  var val=1;
  bool _visible = true;

  @override
  void initState() {

    // TODO: implement initState
    audioManager = AudioManager.STREAM_SYSTEM;
    initAudioStreamType();
    updateVolumes();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    controller = VideoPlayerController.asset('video/bunny.mp4');
    f = controller.initialize();
    controller.setLooping(true);
    controller.play();
    _visible=true;
    startTimer(0);
    super.initState();
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
            future: f,
            builder: (context,snapshot)
            {
              if(snapshot.connectionState == ConnectionState.done)
                {
                    val = currentVol;
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _visible=true;
                              startTimer(0);
                            });
                          },
                          child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: VideoPlayer(controller),
                      ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RotatedBox(
                              quarterTurns: 3,
                              child:
                                  AnimatedOpacity(
                                    opacity: _visible ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 500),
                                    child: Slider(
                                    activeColor: Colors.amberAccent,
                                    inactiveColor: Colors.black54,
                                    value: val.toDouble(),
                                    min: 1.0,
                                    max: maxVol.toDouble(),
                                    onChanged: (double newValue) {
                                      setState(() {
                                        _visible=true;
                                        val = newValue.round();
                                        setVol(val);
                                        updateVolumes();
                                        startTimer(0);
                                      });
                                    },
                                ),
                                  ),
                              ),
                            ]
                          ),
                        ),
                      ]
                    );
                }
              else
                {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: Center(
                        child: Theme(
                            data: Theme.of(context).copyWith(accentColor: Colors.amberAccent),
                            child: CircularProgressIndicator())),
                  );
                }
            },
          )
    );
  }
}


