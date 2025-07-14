import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp_lmhung/app_bloc/bloc.dart';
import 'package:todoapp_lmhung/app_bloc/event.dart';


import '../../app_bloc/state.dart';

class HomepageChoosetheme extends StatefulWidget {
  const HomepageChoosetheme({super.key});

  @override
  State<HomepageChoosetheme> createState() => _HomepageChoosethemeState();
}

class _HomepageChoosethemeState extends State<HomepageChoosetheme> {
  final List<Color> listTheme = [
    Color(0xff24A19C),
    Color(0xff1B1C1F),
    Color(0xffEA4335),
    Color(0xff1877F2),
  ];
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7F9),
      body: SingleChildScrollView(
        child: BlocConsumer<App_Bloc, AppState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                left: 13,
                right: 24,
                top: 24,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Create to do list',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Color(0xff1B1C1F),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Choose your to do list color theme:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff767E8C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 120,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = index;
                                  });
                                  context.read<App_Bloc>().add(SetThemeColorEvent(listTheme[index]));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 9),
                                      height: 104,
                                      decoration: BoxDecoration(
                                        // color: Color(0xffafafaf),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(
                                                0xff0F163A,
                                              ).withValues(alpha: 0.1),
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: listTheme[index],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 16),
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        17,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xffE7ECF5,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Container(),
                                                    ),
                                                    SizedBox(width: 16),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                          ),
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Image.asset(
                                                        'assets/app_images/three_lines.png',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              selectedindex == index
                                  ? Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: listTheme[index],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () => GoRouter.of(context).go('/dashboard'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xff24A19C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Mở Todyapp',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
