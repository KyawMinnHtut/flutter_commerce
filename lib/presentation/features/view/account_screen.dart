import 'package:flutter/material.dart';

import '../../../core/global_listener/global_listener.dart';
import '../../../core/res/global_listener_constants.dart';
import '../../../core/res/string_constants.dart';
import '../../../core/res/text_styles.dart';
import '../../../data/firebase_manager/firestore_manager.dart';
import '../../../data/models/account_details_model.dart';
import '../../../di/di.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../routes/app_router.gr.dart';
import '../../routes/navigation_handler.dart';
import '../../widgets/action_text.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountDetails? accountDetails;

  @override
  void initState() {
    super.initState();
    inject<GlobalListener>().listen<AccountDetails>(GlobalListenerConstants.accountDetails, (event) {
      setState(() {
        accountDetails = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (accountDetails == null)
                      Container()
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            accountDetails!.name,
                            style: AppTextStyles.t33,
                          ),
                          Text(
                            accountDetails!.phoneNumber ?? '',
                            style: AppTextStyles.t28,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionText(
                      StringsConstants.editCaps,
                      onTap: () {
                        NavigationHandler.navigateTo(AddUserDetailScreenRoute(newAddress: false));
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(StringsConstants.myOrders),
                leading: const Icon(Icons.shopping_basket),
                onTap: () {
                  NavigationHandler.navigateTo(const MyOrdersScreenRoute());
                },
              ),
              ListTile(
                title: const Text(StringsConstants.myAddress),
                leading: const Icon(Icons.place),
                onTap: () {
                  NavigationHandler.navigateTo(MyAddressScreenRoute());
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(StringsConstants.logout),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  inject<LogoutUseCase>().execute().then((value) {
                    NavigationHandler.navigateTo(
                      const LoginScreenRoute(),
                      navigationType: NavigationType.pushAndPopUntil,
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
