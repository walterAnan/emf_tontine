
import 'package:emf_tontine/screens/dashboard.dart';
import 'package:flutter/material.dart';
class ChangerMDP extends StatefulWidget {
  const ChangerMDP({Key? key}) : super(key: key);

  @override
  State<ChangerMDP> createState() => _ChangerMDPState();
}

class _ChangerMDPState extends State<ChangerMDP> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            width: MediaQuery.of(context).size.width,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: Text('Changez votre mot de passe !', style: TextStyle(
                        fontSize:18
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextField(
                      obscureText: isChecked == true? false:true,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                        labelText: 'Ancien mot de passe',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextField(
                      obscureText: isChecked == true? false:true,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                        labelText: 'Nouveau mot de passe',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextField(
                      obscureText: isChecked == true? false:true,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                        labelText: 'Confirmer le nouveau',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text('mot de passe visible!')
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35),
                        child: ElevatedButton(
                          child: const Text('Valider'),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   // MaterialPageRoute(builder: (context) =>  const Bottom()),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              textStyle:
                              const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 20,),

                      Expanded(child: Container(),),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          child: const Text('Annuler'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const Dashboard()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              textStyle:
                              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      ),

    );
  }
}
