import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Booking extends StatefulWidget{
  @override
  BookingState createState()=> BookingState();


}
class BookingState extends State<Booking> {
  final GlobalKey <FormState> formkey = GlobalKey<FormState>();
  TextEditingController Purpose= TextEditingController();
  TextEditingController Startdate= TextEditingController();
  TextEditingController  Enddate= TextEditingController();
  TextEditingController Room= TextEditingController();
  TextEditingController Department= TextEditingController();
  TextEditingController MeetingTime= TextEditingController();
  TextEditingController NumberOfParticipant= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'BOOK A ROOM'
      //
      //   ),
      //
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
        child: Form(
          key: formkey,
          child: Column(

            children: <Widget>[
              const Center(
                child: Text.rich(
                  TextSpan(
                    text: 'BOOK A ROOM',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),

                ),

              ),
              const SizedBox(height: 20,),
              TextFormField(
    validator: (value){
    if(value!.isEmpty){
    return "Please Enter Purpose Of Meeting";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Purpose',
                  hintText: 'Purpose of Meeting',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                ),
              ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 2.0),
                    child: TextFormField(
                      controller: Startdate,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_month_outlined),
                        labelText: 'Start date',
                        hintText: 'Select date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                      onTap: () async{
                        DateTime? pickeddate = await showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickeddate != null){
                          setState(() {
                            Startdate.text = DateFormat ('yyy-MM-dd').format(pickeddate);

                          });
                        }
                      },
                    ),

                  ),
                  ),
                ],

              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 2.0),
                    child: TextFormField(
                      controller: Enddate,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_month_outlined),
                        labelText: 'End Date',
                        hintText: 'Select date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                      ),
                      onTap: () async{
                        DateTime? pickeddate = await showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickeddate != null){
                          setState(() {
                            Enddate.text = DateFormat ('yyy-MM-dd').format(pickeddate);

                          });
                        }
                      },
                    ),

                  ),
                  ),
                ],

              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Select Room";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Room',
                  hintText: 'Select Room',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Select Department";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Department',
                  hintText: 'Select Department',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Select Time";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Meeting Time',
                  hintText: 'Select Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Number Of Participant";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Number Of Participant',
                  hintText: ' Enter Number Of Participant',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 55.0,
                width: 300.0,
                child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 10.0,

                    child: const Center(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}


