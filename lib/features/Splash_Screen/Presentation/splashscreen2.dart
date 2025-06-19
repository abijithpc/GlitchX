import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Splash_Screen/Presentation/bloc/splash_bloc.dart';
import 'package:glitchxscndprjt/features/Splash_Screen/Presentation/widgets/loginsplashbtn.dart';
import 'package:glitchxscndprjt/features/Splash_Screen/Presentation/widgets/skipandnxtbtn.dart';
import 'package:glitchxscndprjt/features/Splash_Screen/Presentation/widgets/splashwidget.dart';

class Splashscreen2 extends StatefulWidget {
  const Splashscreen2({super.key});

  @override
  State<Splashscreen2> createState() => _Splashscreen2State();
}

class _Splashscreen2State extends State<Splashscreen2> {
  final controller = PageController();
  bool lastPage = false; // Fixed variable name

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        lastPage = (controller.page == 2);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => SplashBloc(),
      child: Scaffold(
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(bottom: 80),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  context.read<SplashBloc>().add(PageChanged(index));
                },
                children: [
                  SplashContainer(
                    heading: 'Hitman',
                    description:
                        "In Hitman: Blood Money (2006), if you played aggressively and left too much evidence (like bodies, camera footage, or witnesses), future levels would feature more security, tighter patrols, and guards who recognized Agent 47's face from newspaper reports.",
                    backgroundImage:
                        'Assets/SplashPhotos/hitman-phone-gs8ads5iebuthds5.jpg',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SplashContainer(
                    heading: 'Watch Dogs 2',
                    description:
                        "In the game, you can overhear NPCs talking about a new game called 'Space Driver', which is described as a violent open-world game full of crime and chaos—a clear reference to Grand Theft Auto.",
                    backgroundImage:
                        'Assets/SplashPhotos/wp5622162-watch-dogs-hd-phone-wallpapers.jpg',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SplashContainer(
                    heading: 'Grand Theft Auto 5',
                    description:
                        "The ocean in GTA 5 isn’t just for looks—it has a fully simulated underwater ecosystem, including AI-powered sharks that can actually hunt you down! If you go too deep without a submarine, you might become a shark’s next meal.",
                    backgroundImage:
                        'Assets/SplashPhotos/wp6706533-gta-v-android-wallpapers.jpg',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                ],
              ),
            );
          },
        ),
        bottomSheet: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return state.pageIndex == 2
                ? LoginSplashBtn(screenWidth: screenWidth)
                : nxtskipbtn(controller: controller);
          },
        ),
      ),
    );
  }
}
