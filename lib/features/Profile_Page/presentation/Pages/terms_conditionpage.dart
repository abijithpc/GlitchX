import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_state.dart';

class TermsConditionpage extends StatefulWidget {
  const TermsConditionpage({super.key});

  @override
  State<TermsConditionpage> createState() => _TermsConditionpageState();
}

class _TermsConditionpageState extends State<TermsConditionpage> {
  @override
  void initState() {
    super.initState();
    context.read<TermsBloc>().add(LoadTermsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Condition', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ScreenBackGround(
        widget: BlocBuilder<TermsBloc, TermsState>(
          builder: (context, state) {
            if (state is TermsLoading) {
              return buildShimmerLoading();
            } else if (state is TermsLoaded) {
              return Markdown(data: state.content, styleSheet: MarkdownStyle());
            } else if (state is TermsError) {
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
