import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:request_neobis/site_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  

  @override
  State<MyHomePage> createState() => _MyHomepageState();
  
}

class _MyHomepageState extends State<MyHomePage> {

    List<SiteModel> users = [];

    bool _isLoading = true;

    @override
    void initState() {
      super.initState();
      getData();
    }

  void getData() async{

    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      users =
          (response.data as List<dynamic>).map((i) => SiteModel.fromJson(i)).toList();

      setState(() {
        _isLoading = false;
      });
    } else {
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xffFFFACD),
                      child: ListTile(
                        title: Text(
                          'ID = ${users[index].id} UserID = ${users[index].userId}  / title = ${users[index].title}',
                        ),
                        subtitle: Text('BODY = ${users[index].body}'),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}