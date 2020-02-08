import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  var _isShowClear = false;
  var _isShowPwd = false;

  var _username = '';
  var _password = '';

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String validateUsername(value) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  String validatePassword(value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(allowFontScaling: false)..init(context);
    print(ScreenUtil().scaleHeight);

    // logo
    Widget logoArea = Container(
      alignment: Alignment.topCenter,
      child: ClipOval(
        child: Image.asset(
          "assets/images/logo.png",
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget textInputArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "请输入手机号",
              prefixIcon: Icon(Icons.person),
              suffixIcon: _isShowClear
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _usernameController.clear();
                      })
                  : null,
            ),
            validator: validateUsername,
            onSaved: (String value) {
              _username = value;
            },
          ),
          TextFormField(
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isShowPwd ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    })),
            obscureText: !_isShowPwd,
            validator: validatePassword,
            onSaved: (String value) {
              _password = value;
            },
          )
        ],
      )),
    );

    Widget loginButtonArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 50,
      child: RaisedButton(
        onPressed: () {
          _usernameFocusNode.unfocus();
          _passwordFocusNode.unfocus();
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print("username: $_username  , password: $_password");
          }
        },
        color: Colors.blue[300],
        child: Text(
          "Login",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            logoArea,
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            textInputArea,
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            loginButtonArea,
          ],
        ),
      ),
    );
  }
}
