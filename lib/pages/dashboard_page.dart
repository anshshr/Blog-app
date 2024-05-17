// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, use_build_context_synchronously, use_super_parameters, prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable
// ignore_for_file: non_constant_identifier_names, constant_identifier_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_signup_authentication/my%20widgets/my_button.dart';
import 'package:login_signup_authentication/my%20widgets/my_textfield.dart';
import 'package:login_signup_authentication/pages/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  final String token;
  Dashboard({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Map<String, dynamic>> users_blogs = [];

  void set_prefernce() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", widget.token);
  }

  @override
  void initState() {
    super.initState();
    set_prefernce();
    read_data();
  }

  Future create() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            surfaceTintColor: Colors.amber,
            title: Text('Create your own blog !!'),
            backgroundColor: Color.fromARGB(255, 238, 238, 238),
            actions: <Widget>[
              my_textfield(
                  controller: name,
                  display_text: 'Author name',
                  obs_text: false,
                  icon: Icon(Icons.person)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: age,
                  display_text: 'Author age',
                  obs_text: false,
                  icon: Icon(Icons.height_sharp)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: title,
                  display_text: 'Title of blog',
                  obs_text: false,
                  icon: Icon(Icons.create)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: description,
                  display_text: 'Description',
                  obs_text: false,
                  icon: Icon(Icons.description)),
              SizedBox(
                height: 10,
              ),
              my_button(
                  text: 'C R E A T E',
                  color: Colors.lightBlue,
                  ontap: () async {
                    var newBlog = await store_in_db();
                    if (newBlog != null) {
                      setState(() {
                        users_blogs
                            .add(newBlog); // Add the new blog to the list
                      });
                    }
                    name.clear();
                    age.clear();
                    title.clear();
                    description.clear();
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }

  Future<void> read_data() async {
    try {
      var response =
          await http.get(Uri.parse("http://192.168.162.230:3000/api/getblogs"));

      if (response.statusCode == 200) {
        var json_response = json.decode(response.body);
        // print(json_response);
        for (Map<String, dynamic> b in json_response) {
          users_blogs.add(b);
        }
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>?> store_in_db() async {
    try {
      var blog_data = {
        "name": name.text,
        "age": age.text,
        "title": title.text,
        "description": description.text,
      };

      var response = await http.post(
        Uri.parse('http://192.168.162.230:3000/api/createblog'),
        body: jsonEncode(blog_data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // var json_response = await jsonDecode(response.body);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future update_dialog(String input_name, int input_age, String input_title,
      String ip_desc, String user_id) {
    TextEditingController up_name = TextEditingController(text: input_name);
    TextEditingController up_age = TextEditingController(text: '$input_age');
    TextEditingController up_title = TextEditingController(text: input_title);
    TextEditingController up_desc = TextEditingController(text: ip_desc);

    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            surfaceTintColor: Colors.amber,
            title: Text('Update your blog'),
            backgroundColor: Color.fromARGB(255, 238, 238, 238),
            actions: <Widget>[
              my_textfield(
                  controller: up_name,
                  display_text: 'Author name',
                  obs_text: false,
                  icon: Icon(Icons.person)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: up_age,
                  display_text: 'Author age',
                  obs_text: false,
                  icon: Icon(Icons.height_sharp)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: up_title,
                  display_text: 'Title of blog',
                  obs_text: false,
                  icon: Icon(Icons.create)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: up_desc,
                  display_text: 'Description',
                  obs_text: false,
                  icon: Icon(Icons.description)),
              SizedBox(
                height: 10,
              ),
              my_button(
                  text: 'U P D A T E',
                  color: Colors.lightBlue,
                  ontap: () async {
                    var user_upadtion = {
                      'name': up_name.text,
                      'age': up_age.text,
                      "title": up_title.text,
                      "description": up_desc.text,
                      "user_id": user_id
                    };

                    try {
                      var response = await http.post(
                        Uri.parse('http://192.168.162.230:3000/api/update'),
                        body: jsonEncode(user_upadtion),
                        headers: {'Content-Type': 'application/json'},
                      );

                      if (response.statusCode == 200) {
                        setState(() {
                          var index = users_blogs
                              .indexWhere((blog) => blog['_id'] == user_id);
                          if (index != -1) {
                            users_blogs[index] =
                                user_upadtion; // Update the blog in the list
                          }
                        });
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await create();
          },
          tooltip: 'Create a new Blog',
          child: Icon(
            Icons.add,
            color: Colors.purple[500],
            weight: 500,
            size: 20,
          )),
      appBar: AppBar(
        title: const Text('Dashboard Page'),
        backgroundColor: Colors.deepPurple[100],
        leading: GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("token", "");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login_page(),
                  ));
            },
            child: Icon(Icons.logout)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: users_blogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    color: Colors.lightBlue[100],
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () async {
                            String val = users_blogs[index]['_id'];
                            print(val);
                            var json_response = {};
                            try {
                              var response = await http.get(Uri.parse(
                                  "http://192.168.162.230:3000/api/getblogs/$val"));
                              if (response.statusCode == 200) {
                                json_response = json.decode(response.body);
                                print(json_response);
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                            update_dialog(
                                json_response['name'],
                                json_response['age'],
                                json_response['title'],
                                json_response['description'],
                                json_response['_id']);
                          },
                          icon: Icon(Icons.settings)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          String id = users_blogs[index]['_id'];
                          try {
                            var response = await http.get(Uri.parse(
                                'http://192.168.162.230:3000/api/getblogs/$id'));
                            if (response.statusCode == 200) {
                              print(jsonDecode(response.body));
                              setState(() {
                                int index = users_blogs
                                    .indexWhere((blog) => blog['_id'] == id);
                                users_blogs.removeAt(index);
                              });
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                      onLongPress: () async {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: SingleChildScrollView(
                                child: Container(
                                    color: Colors.grey[300],
                                    height:
                                        MediaQuery.of(context).size.height * 0.7,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Lottie.network('https://lottie.host/aaea5fe2-efd1-4174-81c4-454812bcc31d/mc8YFNy5Qd.json'),
                                          Text(
                                              "Name of Author :  ${users_blogs[index]['name']}",style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                                              
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              "Age of Author :  ${users_blogs[index]['age']}",style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              "Title of Author :  ${users_blogs[index]['title']}",style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              "Description of Author :  ${users_blogs[index]['description']}",style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        );
                      },
                      title: Text(
                        users_blogs[index]['title'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        users_blogs[index]['description'],
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
