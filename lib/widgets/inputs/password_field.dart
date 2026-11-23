import 'package:material_ui/material_ui.dart';
import '../../theme/app_colors.dart';
import 'app_text_field.dart';

class PasswordField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  const PasswordField({
    super.key,
    this.labelText,
    this.hintText = 'Enter your password',
    this.controller,
    this.validator,
    this.onChanged,
    this.textInputAction,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}