import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_login.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import '../../../shared/components/components.dart';


class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardingController = PageController();

  List<BoardingModel> boarding =
  [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 1 Body',
      title: 'On Board 1 Title',
    ),
    BoardingModel(
      image: 'assets/images/onboard_2.jpg',
      body: 'On Board 2 Body',
      title: 'On Board 2 Title',
    ),
    BoardingModel(
      image: 'assets/images/onboard_3.jpg',
      body: 'On Board 3 Body',
      title: 'On Board 3 Title',
    ),
  ];

  bool isLast = false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: ()
              {
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: HexColor('6C63FF'),
                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
        children:
        [
          Expanded(
            child: PageView.builder(
            controller: boardingController,
            onPageChanged: (int index)
            {
              if(index == boarding.length - 1)
              {
                setState(()
                {
                  isLast = true;
                });
                print('last');
              }
              else
              {
                print('not last');
                setState(()
                {
                  isLast=false;
                });
              }
            },
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildOnBoardingItem(boarding[index]),
            itemCount: boarding.length,

        ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children:
            [
              SmoothPageIndicator(
                  controller: boardingController,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    spacing: 5.0,
                    activeDotColor: HexColor('6C63FF'),
                    expansionFactor: 4,

                  ),
                  count: boarding.length,
              ),
              Spacer(), //بياخذ كل المسافة إلي// بينهم
              FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    } else
                    {
                      boardingController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  backgroundColor: HexColor('6C63FF'),
              ),
            ],
          ),
        ],
    ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: GoogleFonts.kalam(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.body}',
        style: GoogleFonts.kalam(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),

    ],
  );
}
