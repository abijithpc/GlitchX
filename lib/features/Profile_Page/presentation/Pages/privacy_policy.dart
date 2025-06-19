import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_state.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicyPage> {
  @override
  void initState() {
    super.initState();
    context.read<PrivacyBloc>().add(LoadPrivacyPolicy());
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Policy', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ScreenBackGround(
        widget: BlocBuilder<PrivacyBloc, PrivacyPolicyState>(
          builder: (context, state) {
            if (state is PrivacyPolicyLoading) {
              return buildShimmerLoading();
            } else if (state is PrivacyPolicyLoaded) {
              return Markdown(data: state.content, styleSheet: MarkdownStyle());
            } else if (state is PrivacyPolicyError) {
              return Center(child: Text(state.message));
            }
            return SizedBox.shrink();
          },
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
