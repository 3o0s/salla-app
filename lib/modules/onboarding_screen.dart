import 'package:flutter/material.dart';
import 'package:shopapp/model/onboarding_model.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageController pageController = PageController();
List<BoardingModel> boardingList = [
  BoardingModel(image: 'images/shop2.jpg', title: 'Title 1', body: 'Body 1'),
  BoardingModel(image: 'images/shop2.jpg', title: 'Title 2', body: 'Body 2'),
  BoardingModel(image: 'images/shop2.jpg', title: 'Title 3', body: 'Body 3'),
];
void submit(context) {
  CachHelper.saveData('onBoarding', true).then((value) {
    if (value) {
      navigateAndReplace(context, const LoginScreen());
    }
  });
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: const Text(
              'Skip',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: boardingList.length,
                itemBuilder: (context, index) => onBoardingpage(
                  model: boardingList[index],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: 'one',
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  controller: pageController,
                  count: boardingList.length,
                ),
                FloatingActionButton(
                  heroTag: 'two',
                  onPressed: () {
                    if (pageController.page! < 2) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    } else {
                      submit(context);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget onBoardingpage({required BoardingModel model}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                // height: MediaQuery.of(context).size.height / 2,
                image: AssetImage(
                  model.image,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
