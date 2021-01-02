import 'package:flutter/material.dart';

import 'package:validators/validators.dart';

import 'InputFields.dart';

class FormContainer extends StatelessWidget {
  final formKey;
  final emailController;
  final nameController;
  final phonController;
  final inviteController;
  FormContainer({@required this.formKey, this.emailController, this.nameController,this.phonController,this.inviteController });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: new Column(
        children: <Widget>[
          new Form(
            key : formKey,
            child: new Column(
              children: <Widget>[
                new InputFieldArea(
                  keyboardtype: TextInputType.text,
                  hint: "نام و نام خانوادگی",
                  validator: (String value) {
                    if(value.length==0) {
                      return
                          'نام خود را وارد کنید!';
                    }
                  },
                    controller : nameController
                ),
                 InputFieldArea(
                  keyboardtype: TextInputType.phone,
                  hint: "شماره موبایل",
                  validator: (String value) {
                    if(value.length<11) {
                      return 'شماره موبایل صحیح نمی باشد!';
                    }
                  },
                    controller : phonController
                ),
                new InputFieldArea(
                  keyboardtype: TextInputType.text,
                  hint: "در صورت داشتن کد معرف آن را وارد کنید.",
                  validator: (String value) {
//                    if(value.length<11) {
//                      return 'کد معرف صحیح نمی باشد!';
//                    }
                  },
                    controller : inviteController
                ),
//                new InputFieldArea(
//                  keyboardtype: TextInputType.emailAddress,
//                  hint: "ایمیل",
//                  validator: (String value) {
//                    if(!isEmail(value)) {
//                      return 'ایمیل صحیح نمیباشد!';
//                    }
//                  },
//                    controller : emailController
//                ),
              ],
            ),

          )
        ],
      ),
    );
  }

}