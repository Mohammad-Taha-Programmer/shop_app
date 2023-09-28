import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                showToast(text: state.loginModel.message, state: ToastStates.success);
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(text: state.loginModel.message, state: ToastStates.error);
            }
          }
        },
        builder: (BuildContext context, ShopStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            defaultFormField(
                                controller: _emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your email address';
                                  }
                                  return null;
                                },
                                label: 'Email Address',
                                hint: 'Enter your email address',
                                prefix: const Icon(Icons.email_outlined),
                                suffix: null),
                            const SizedBox(height: 15),
                            defaultFormField(
                                controller: _passwordController,
                                isPassword: ShopLoginCubit.get(context).isPassword,
                                type: TextInputType.visiblePassword,
                                onSubmit: (String value){
                                  if(_formKey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(email: _emailController.text, password: _passwordController.text);
                                  }
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'password is too short';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                hint: 'Enter your password',
                                prefix: const Icon(Icons.lock_outline),
                                suffix: IconButton(
                                  icon: Icon(ShopLoginCubit.get(context).suffix),
                                  onPressed: () => ShopLoginCubit.get(context).changePasswordVisibility(),
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () {
                                if(_formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(email: _emailController.text, password: _passwordController.text);
                                }
                              },
                              text: 'Login',
                              isUpperCase: true),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator())
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          defaultTextButton(
                              function: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              text: 'Register')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
