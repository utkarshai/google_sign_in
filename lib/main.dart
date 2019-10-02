import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() { runApp(MaterialApp(
      title: 'Gmail Sign in',
      home: SignInDemo(),
    ));}

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;


  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Stack(children: <Widget>[
        Image.network("https://images.unsplash.com/photo-1553356084-58ef4a67b2a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
         _currentUser==null? a1(): a2()//_buildBody()),

      ],)
      
    );
  }

  Widget a2(){

    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

        
        children: <Widget>[
          Container(
            child: CircleAvatar(
            child:  Image.network(_currentUser.photoUrl, ) ?? _currentUser,

      
          ),
          height: 200.0,
          width: 200.0,
          color: Colors.yellow,
          ),
          
          ListTile(
            leading: 
               Image.network(_currentUser.photoUrl) ?? _currentUser,
            
            title: Text(_currentUser.displayName ?? '', style: TextStyle(color: Colors.red, fontSize: 30.0),),
            subtitle: Text(_currentUser.email ?? '', style: TextStyle(color: Colors.yellow, fontSize: 20.0),),
          ),
          RaisedButton(
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
            color: Colors.pinkAccent.withOpacity(0.7),
          )
        ],
      ),);
    
  }

  Widget a1(){
    return Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       
        children: <Widget>[
          Text('wanna sign in', style: TextStyle(color: Colors.black, fontSize: 30.0),),
          
          Padding(padding: EdgeInsets.all(70.0), child: RaisedButton(
            onPressed: _handleSignIn,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
            color: Colors.white,
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(FontAwesomeIcons.google, color: Colors.pink,),
                SizedBox(width: 10.0,),
                Text('SIGN IN', style: TextStyle(fontSize: 30.0, color: Colors.green),),    
            ],)
            
          ),)
          
        ],
      ),);
  }

  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
    }catch(error){
      print(error);
    }
  }

  Future<void> _handleSignOut() async{
    _googleSignIn.signOut();
  }
}