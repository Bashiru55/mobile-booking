import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'navbar.dart';
import 'dashboard.dart';
import 'booking.dart';
import 'changepassword.dart';
import 'adduser.dart';
import 'resetpassword.dart';
import 'changeuserrole.dart';
import 'logout.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {
  var currentPage = NavSection.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage==NavSection.dashboard){
      container= const Dashboard();
    }else if(currentPage==NavSection.booking){
      container= Booking();
    }else if(currentPage==NavSection.changepassword){
      container= const ChangePassword();
    }else if(currentPage==NavSection.adduser){
      container= const AddUser();
    }else if(currentPage==NavSection.resetpassword){
      container=ResetPassword();
    }else if(currentPage==NavSection.changeuserrole){
      container=ChangeUserRole();
    }else if(currentPage==NavSection.logout) {
      container = Logout();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text('FC AVAILABILITY SYSTEM'),
        ),
body: container,
      drawer:
        Drawer(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  // NavHeader(),
                  NavList(),
                ],
              ),
          ),
        ),

    );
  }


  Widget NavList(){
    return Container(
      padding: EdgeInsets.only(
        top: 25,
      ),
      child: Column(
        children: [
          NavBar(),
          SizedBox(
            height: 30,
          ),
          menuItem(1,'Dashboard',Icons.dashboard_outlined,
              currentPage==NavSection.dashboard? true:false),
          Divider(),
          SizedBox(
            height: 15,
          ),
          menuItem(2,'Booking',Icons.book,
              currentPage==NavSection.booking? true:false),
          Divider(),
          SizedBox(
            height: 15,
          ),
          menuItem(3,'Change Password',Icons.change_circle,
              currentPage==NavSection.changepassword? true:false),
          Divider(),
          SizedBox(
            height: 15,
          ),
          menuItem(4,'Add User',Icons.verified_user,
              currentPage==NavSection.adduser? true:false),
          Divider(),
          SizedBox(
            height: 15,
          ),
          menuItem(5,'Reset password',Icons.lock_reset,
              currentPage==NavSection.resetpassword? true:false),
          Divider(),
          SizedBox(
            height: 15,
          ),
          menuItem(6,'Change User Role',Icons.change_circle,
              currentPage==NavSection.changeuserrole? true:false),
          Divider(),
          SizedBox(
            height: 50,
          ),
          // menuItem(7,'Logout', Icons.exit_to_app_outlined,
          //     currentPage==NavSection.logout? true:false),
          TextButton(onPressed: (){
            Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Logout()));
          }, child:const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 20),))
        ],

      ),
    );
  }
  Widget menuItem(int id,String title,IconData icon, bool selected){
    return Material(
      color: selected? Colors.grey[300]:Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            if (id==1){
              currentPage= NavSection.dashboard;
            }
            else if (id==2){
              currentPage=NavSection.booking;
            }
            else if(id==3){
              currentPage=NavSection.changepassword;
            }
            else if(id==4){
              currentPage=NavSection.adduser;
            }
            else if(id==5){
              currentPage=NavSection.resetpassword;
            }
            else if(id==6){
              currentPage=NavSection.changeuserrole;
            }
            else if(id==7){
              currentPage=NavSection.logout;
            }
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),

            ),
            Expanded(
              flex: 6,
              child: Text(
                title,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
enum NavSection{
  dashboard,
  booking,
  changepassword,
  adduser,
  resetpassword,
  changeuserrole,
  logout
}
