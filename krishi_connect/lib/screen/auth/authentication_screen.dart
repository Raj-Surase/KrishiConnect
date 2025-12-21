import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/custom_widgets/custom_scaffold.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';
import 'package:krishi_connect/provider/api_provider.dart';
import 'package:krishi_connect/repo/api.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLogin = true;
  bool loading = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _role = 'farmer';

  Future<void> _login() async {
    setState(() => loading = true);

    try {
      final api = context.read<ApiProvider>();

      final token = await api.authApi.loginForAccessTokenApiV1AuthLoginPost(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (token == null) throw Exception("Invalid credentials");

      api.setToken(token.accessToken);

      final user = await api.authApi.readUsersMeApiV1AuthMeGet();

      if (!mounted) return;

      if (user?.role == 'admin') {
        context.go('/admin');
      } else {
        context.go('/user');
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _register() async {
    setState(() => loading = true);

    try {
      final api = context.read<ApiProvider>();

      await api.authApi.registerUserApiV1AuthRegisterPost(
        UserCreate(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          role: _role,
        ),
      );

      setState(() => isLogin = true);

      _showError("Registration successful. Please login.");
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 200.h, child: Image.asset(AppAssets.appBanner)),
              30.verticalSpace,

              CommonContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        isLogin ? "Login" : "Register",
                        style: context.textTheme.titleLarge,
                      ),
                      20.verticalSpace,

                      /// USERNAME
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      15.verticalSpace,

                      /// PASSWORD
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                      ),

                      /// ROLE (REGISTER ONLY)
                      if (!isLogin) ...[
                        15.verticalSpace,
                        DropdownButtonFormField<String>(
                          value: _role,
                          items: const [
                            DropdownMenuItem(
                              value: 'farmer',
                              child: Text("Farmer"),
                            ),
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text("Admin"),
                            ),
                          ],
                          onChanged: (val) => setState(() => _role = val!),
                          decoration: const InputDecoration(labelText: "Role"),
                        ),
                      ],

                      25.verticalSpace,

                      /// ACTION BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : (isLogin ? _login : _register),
                          child: Text(
                            loading
                                ? "Please wait..."
                                : isLogin
                                ? "Login"
                                : "Register",
                          ),
                        ),
                      ),

                      15.verticalSpace,

                      /// TOGGLE
                      TextButton(
                        onPressed: () {
                          setState(() => isLogin = !isLogin);
                        },
                        child: Text(
                          isLogin
                              ? "Don't have an account? Register"
                              : "Already have an account? Login",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
