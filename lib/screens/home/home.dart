import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/authentication.dart';
import 'package:webrtc_conference/cubits/login.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Большая часть изменений в этом файле

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  State<StatefulWidget> createState() {
    return HomePageState();
  }

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/home',
      builder: (_) => this,
    );
  }
}

//Я перенесу потом эти классы в отдельные файлики чтобы этот не был настолько захламлен
//Класс для будущего скрина
class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Info"));
  }
}

//Класс для будущего скрина чата
class MyChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Chat"));
  }
}

//Класс для скрина главной страницы
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Agenda',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Speaker',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 15),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Attendees',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//Класс для будущего скрина профиля

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile"));
  }
}

//Класс для формы с поиском

class MySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Search"));
  }
}

//Просто заменяем контент scafold в зависимости от выбранного окна в navigatonbar
class HomePageState extends State<HomeScreen> {
  int selectedIndex = 2;
  Widget _mychat = MyChat();
  Widget _myinfo = MyInfo();
  Widget _myhome = MyHome();
  Widget _mysearch = MySearch();
  Widget _myprofile = MyProfile();
//Appbar, Drawer и NavigdationBar расписаны тут
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80))),
            actions: <Widget>[
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.notifications_outlined))
            ],
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.cyan),
            centerTitle: true,
            title: Image.asset(
              'assets/images/ADSD_Logo_small.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.pngall.com/wp-content/uploads/2016/05/Man-Download-PNG.png'),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  accountName: Text(
                    'jon jon',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  accountEmail: Text(
                    'umail@mail.ru',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text('Home'),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: Text('Profile'),
                leading: const Icon(Icons.person),
                onTap: () {},
              ),
              ListTile(
                title: Text('About us'),
                leading: const Icon(Icons.info),
                onTap: () {},
              ),
              ListTile(
                title: Text('Contact us'),
                leading: const Icon(Icons.phone),
                onTap: () {},
              ),
              ListTile(
                title: Text('Log out'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  context.read<AuthenticationCubit>().requestLogout();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(color: Colors.cyan, size: 30),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              label: 'Mail',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Info',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_off_outlined),
              label: 'Search',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            )
          ],
          onTap: (int index) {
            this.onTapHandler(index);
          },
          currentIndex: selectedIndex,
          selectedItemColor: Colors.cyan,
        ),
        body: this.getBody());
  }

//По сути контролер выбранного скрина
  Widget getBody() {
    switch (selectedIndex) {
      case 0:
        return _mychat;
      case 1:
        return _myinfo;
      case 2:
        return _myhome;
      case 3:
        return _mysearch;
      case 4:
        return _myprofile;
      default:
        return _myhome;
    }
  }

//Переключатель скрина
  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

//В принципе это уже не нужно так как сделал кнопочку logout в Drawer
class LogOutForm extends StatelessWidget {
  const LogOutForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: SizedBox(
          height: 200.0,
          child: Column(
            children: [
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (BuildContext context, AuthenticationState state) {
                  return Text(
                      'You are logged in as "${state.user.email}" with token "${state.user.token}"');
                },
              ),
              // const Text('You are logged in'),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().requestLogout();
                },
                child: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(0, 164, 212, 1.0),
                  fixedSize: const Size(119, 20),
                ),
              ),
            ],
          ),
        )));
  }
}
