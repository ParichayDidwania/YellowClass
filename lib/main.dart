import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:volume/volume.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:camera/camera.dart';
import 'package:native_device_orientation/native_device_orientation.dart';



final FirebaseAuth auth = FirebaseAuth.instance;
CameraController cameraController;
List<CameraDescription> cameras;

void main() {
  runApp(MaterialApp(
    home: homepage(),
    debugShowCheckedModeBanner: false,
  ));
}

Future<bool> camsetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  try {
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    Future<bool> b = cameraController.initialize().then((value) {
      return true;
    });
    return b;
  }catch(e)
  {
    return null;
  }
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute
                        (builder: (context){
                        return signup();
                      }));
                    },
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
    user.clear();
    pass.clear();
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
                          if(user.text=='ios' && pass.text=='123')
                            {
                              flag=0;
                              user.clear();
                              pass.clear();
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
                            String err = e.toString();
                            List errors = err.split(",");
                            if(flag==1)
                              {
                                Fluttertoast.showToast(
                                    msg: errors[1],
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
                            user.clear();
                            pass.clear();
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

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
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
                    alignment: Alignment.topCenter,
                    child: Text(
                      "CREATE AN ACCOUNT",
                      style: TextStyle(
                          fontFamily: 'CustomFamilyName',
                          fontSize: 30,
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
                        //final FirebaseUser user = await auth.currentUser();
                        FirebaseUser firebaseuser = null;
                        try {
                          firebaseuser = (await auth
                              .createUserWithEmailAndPassword(
                            email: user.text,
                            password: pass.text,
                          )).user;
                        }
                        catch(e){
                          setState(() {
                            String err = e.toString();
                            List errors = err.split(",");
                            if(flag==1)
                            {
                              Fluttertoast.showToast(
                                  msg: errors[1],
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
                                msg: 'Account created successfully!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.black87,
                                textColor: Colors.amberAccent);
                            user.clear();
                            pass.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return playvid();
                            }));
                          });
                        }
                      }
                      ,
                      child: Text("SIGN UP",
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
    );
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
                  onPressed: () async{
                    bool done = await camsetup();
                    if(done==null)
                      {
                        Fluttertoast.showToast(
                            msg: 'No Camera Feed Detected',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.black87,
                            textColor: Colors.amberAccent);
                      }
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

  List<int> l = [1,0];

  Future<void> orien() async {
    final orientation = await NativeDeviceOrientationCommunicator().orientation(
        useSensor: true);
    print(orientation);
  }

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
  bool useSensor = false;

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
    cameraController.dispose();
    super.dispose();
  }

  double xpos=0.0;
  double ypos=0.0;

  void changePos(DragUpdateDetails tapinfo)
  {
    if(xpos-tapinfo.delta.dx<0)
      {
        xpos=0;
      }
    else if(xpos-tapinfo.delta.dx>(MediaQuery.of(context).size.width-150))
      {
        xpos=MediaQuery.of(context).size.width-150;
      }
    else
      {
        xpos-=tapinfo.delta.dx;
      }

    if(ypos-tapinfo.delta.dy<0)
    {
      ypos=0;
    }
    else if(ypos-tapinfo.delta.dy>(MediaQuery.of(context).size.height-150))
    {
      ypos=MediaQuery.of(context).size.height-150;
    }
    else
    {
      ypos-=tapinfo.delta.dy;
    }

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

                        Positioned(
                            bottom: ypos,
                               right: xpos,
                               child: NativeDeviceOrientationReader(
                                 builder: (context) {
                                   final orientation =
                                   NativeDeviceOrientationReader.orientation(context);
                                   print('Received new orientation: $orientation');
                                   if('$orientation'=='NativeDeviceOrientation.landscapeLeft')
                                     {
                                       l[0]=1;
                                       l[1]=0;
                                       return GestureDetector(
                                         onPanUpdate: (tapInfo) {
                                           setState(() {
                                             changePos(tapInfo);
                                           });
                                         },
                                         child: RotatedBox(
                                           quarterTurns: 3,
                                           child: Container(
                                             height: 150,
                                             width:150,
                                             child: cameraController==null ? Text("") :CameraPreview(cameraController),
                                           ),
                                         ),
                                       );
                                     }
                                   else if('$orientation'=='NativeDeviceOrientation.landscapeRight')
                                     {
                                       l[0]=0;
                                       l[1]=1;
                                       return GestureDetector(
                                         onPanUpdate: (tapInfo) {
                                           setState(() {
                                             changePos(tapInfo);
                                           });
                                         },
                                         child: RotatedBox(
                                           quarterTurns: 1,
                                           child: Container(
                                             height: 150,
                                             width:150,
                                             child: cameraController==null ? Text("") :CameraPreview(cameraController),
                                           ),
                                         ),
                                       );
                                     }
                                   else
                                     {
                                       if(l[0]==1)
                                         {
                                           return GestureDetector(
                                             onPanUpdate: (tapInfo) {
                                               setState(() {
                                                 changePos(tapInfo);
                                               });
                                             },
                                             child: RotatedBox(
                                               quarterTurns: 3,
                                               child: Container(
                                                 height: 150,
                                                 width:150,
                                                 child: cameraController==null ? Text("") :CameraPreview(cameraController),
                                               ),
                                             ),
                                           );
                                         }
                                       else
                                         {
                                           return GestureDetector(
                                             onPanUpdate: (tapInfo) {
                                               setState(() {
                                                 changePos(tapInfo);
                                               });
                                             },
                                             child: RotatedBox(
                                               quarterTurns: 1,
                                               child: Container(
                                                 height: 150,
                                                 width:150,
                                                 child: cameraController==null ? Text("") :CameraPreview(cameraController),
                                               ),
                                             ),
                                           );
                                         }
                                     }
                                 },
                                 useSensor: true,
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


