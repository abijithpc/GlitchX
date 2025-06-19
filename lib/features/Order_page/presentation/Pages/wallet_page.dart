import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_state.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/wallet_widget.dart';

class WalletPage extends StatefulWidget {
  final String userId;

  const WalletPage({super.key, required this.userId});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();
    final walletBloc = context.read<WalletBloc>();
    walletBloc.add(LoadWallet(widget.userId));
    // walletBloc.add(LoadWallet(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: ScreenBackGround(
        screenHeight: screen.size.height,
        screenWidth: screen.size.width,
        alignment: Alignment.topCenter,
        widget: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WalletLoaded) {
              return Column(
                children: [
                  buildWalletCard(state.wallet.balance),
                  const SizedBox(height: 8),
                  Expanded(
                    child:
                        state.transactions == null
                            ? const Center(child: CircularProgressIndicator())
                            : state.transactions.isEmpty
                            ? const Center(
                              child: Text('No transactions found.'),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: state.transactions.length,
                              itemBuilder: (context, index) {
                                final tx = state.transactions[index];
                                return buildTransactionTile(tx);
                              },
                            ),
                  ),
                ],
              );
            } else if (state is WalletError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
