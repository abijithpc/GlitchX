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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenHeight = screen.height;
    final screenWidth = screen.width;

    return BlocProvider(
      create: (context) => SplashBloc(),
      child: Scaffold(
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return PageView(
              controller: controller,
              onPageChanged: (index) {
                context.read<SplashBloc>().add(PageChanged(index));
              },
              children: [
                SplashContainer(
                  heading: 'Hitman',
                  description:
                      "In Hitman: Blood Money (2006), if you played aggressively and left too much evidence...",
                  backgroundImage:
                      'Assets/SplashPhotos/hitman-phone-gs8ads5iebuthds5.jpg',
                  landscapeImage:
                      'Assets/image/hitman-adjusting-glove-2np2yvf7qu8vkoyx.jpg',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SplashContainer(
                  heading: 'Watch Dogs 2',
                  description:
                      "You can overhear NPCs talking about a new game called 'Space Driver'...",
                  backgroundImage:
                      'Assets/SplashPhotos/wp5622162-watch-dogs-hd-phone-wallpapers.jpg',
                  landscapeImage:
                      'Assets/image/watch-dogs-mlo7g7kp92rt4cpf.jpg',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SplashContainer(
                  heading: 'Grand Theft Auto 5',
                  landscapeImage:
                      'Assets/image/gta-5-landscape-collage-a0udfu5lk2jdqfb3.jpg',
                  description:
                      "The ocean in GTA 5 has a fully simulated underwater ecosystem...",
                  backgroundImage:
                      'Assets/SplashPhotos/wp6706533-gta-v-android-wallpapers.jpg',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ],
            );
          },
        ),
        bottomSheet: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              child:
                  state.pageIndex == 2
                      ? LoginSplashBtn(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      )
                      : NxtSkipBtn(
                        controller: controller,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
            );
          },
        ),
      ),
    );
  }
}
