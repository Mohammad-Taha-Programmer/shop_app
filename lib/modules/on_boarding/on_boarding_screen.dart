import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image, title, body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/images/1.png', title: 'Plan Your Trip', body: 'Get Different Warranties of flights from our trusted partners to all over the globe'),
    BoardingModel(image: 'assets/images/2.png', title: 'Book Your Flight', body: 'After you\'ve planned your trip, it\'s a good time to book your flight'),
    BoardingModel(image: 'assets/images/3.png', title: 'Enjoy The Trip', body: 'Live the dream, Enjoy your life at it\'s fullest, Don\'t look back at time!'),
  ];
  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [defaultTextButton(function: submit, text: 'skip')]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  setState(() {
                    if(index == boarding.length -1){
                      isLast = true;
                    }else{
                      isLast = false;
                    }
                  });
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index){
                    return buildBoardingItem(model: boarding[index]);
                  }
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      activeDotColor: defaultColor
                  ),
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){

                  if(isLast) {
                    submit();
                  }else{
                    boardController.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.linear);
                  }
                }, child: const Icon(Icons.arrow_forward_ios))
              ],
            ),
            const SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem({required BoardingModel model}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image), fit: BoxFit.cover,)),
        const SizedBox(height: 30),
        Text(
          model.title,
          style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 15),
        Text(
          model.body,
          style: const TextStyle(
              fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
