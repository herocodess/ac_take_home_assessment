import 'package:acumen_technical_assessment/core/services/navigation_service.dart';
import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/core/utils/images.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/core/utils/validators.dart';
import 'package:acumen_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:acumen_technical_assessment/features/products/presentation/views/products_view.dart';
import 'package:acumen_technical_assessment/widgets/alerts.dart';
import 'package:acumen_technical_assessment/widgets/buttons.dart';
import 'package:acumen_technical_assessment/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState<bool>(true);
    final formKey = useState<GlobalKey<FormState>>(GlobalKey());

    final isLoading = useState<bool>(false);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomSheet: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: PrimaryButton(
          isLoading: isLoading.value,
          onTap: () {
            if (formKey.value.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();

              final RequestParams<String> params = {
                "email": emailController.text.replaceAll(' ', ''),
                "password": passwordController.text.replaceAll(' ', '')
              };

              authBloc.add(LoginUserEvent(params: params));
            }
          },
          text: context.l10n.continue_text,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.07,
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is LoginLoadingState) {
                isLoading.value = true;
              }

              if (state is LoginFailureState) {
                isLoading.value = false;
                Alerts.show(state.error, context);
              }

              if (state is LoginSuccessState) {
                isLoading.value = false;
                pushToAndClearStack(context, const ProductsView());
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: CupertinoButton(
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          context.l10n.signup,
                          style: GoogleFonts.dmSans(
                            color: AppColors.darkButtonColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      context.l10n.login,
                      style: GoogleFonts.dmSans(
                        color: AppColors.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      context.l10n.login_subtext,
                      style: GoogleFonts.dmSans(
                        color: AppColors.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),
                    InputFields(
                      controller: emailController,
                      hint: context.l10n.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (p0) =>
                          Validators.validateEmail(context, p0 ?? ''),
                    ),
                    const SizedBox(height: 20),
                    InputFields(
                      controller: passwordController,
                      hint: context.l10n.password,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      isPassword: obscureText.value,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return context.l10n.password_is_required;
                        }
                        return null;
                      },
                      suffixIcon: CupertinoButton(
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          obscureText.value = !obscureText.value;
                        },
                        child: obscureText.value
                            ? const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 14,
                                color: AppColors.whiteColor,
                              )
                            : Image.asset(
                                AppImages.passwordHidden,
                                scale: 2.2,
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          context.l10n.forgot_password,
                          style: GoogleFonts.dmSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkButtonColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
