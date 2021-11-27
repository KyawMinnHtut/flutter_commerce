import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/features/app/repo/auth_repository.dart';
import 'package:fluttercommerce/features/common/widgets/action_text.dart';
import 'package:fluttercommerce/features/order/bloc/account_details_cubit.dart';
import 'package:fluttercommerce/features/order/state/account_details_state.dart';
import 'package:fluttercommerce/routes/router.gr.dart';
import 'package:fluttercommerce/res/string_constants.dart';
import 'package:fluttercommerce/res/text_styles.dart';
import 'package:fluttercommerce/di/di.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var accountDetailsCubit = DI.container<AccountDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                          bloc : accountDetailsCubit,
                          builder: (context, accountDetailState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  accountDetailState.accountDetails!.name,
                                  style: AppTextStyles.medium22Black,
                                ),
                                Text(
                                  accountDetailState.accountDetails!.phoneNumber,
                                  style: AppTextStyles.normal14Color4C4C6F,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ActionText(
                          StringsConstants.editCaps,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AddUserDetailScreenRoute.name,
                                arguments: AddUserDetailScreenRouteArgs(
                                    newAddress: false));
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(StringsConstants.myOrders),
                    leading: Icon(Icons.shopping_basket),
                    onTap: () {
                      Navigator.of(context).pushNamed(MyOrdersScreenRoute.name);
                    },
                  ),
                  ListTile(
                    title: Text(StringsConstants.myAddress),
                    leading: Icon(Icons.place),
                    onTap: () {
                      Navigator.of(context).pushNamed(MyAddressScreenRoute.name);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(StringsConstants.logout),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      DI.container<AuthRepository>()
                          .logoutUser()
                          .then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScreenRoute.name, (route) => false);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
