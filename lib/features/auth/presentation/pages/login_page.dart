import 'package:flutter/material.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginPage({super.key, required this.authBloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLogin = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    widget.authBloc.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    widget.authBloc.removeListener(_onAuthStateChanged);
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onAuthStateChanged() {
    final state = widget.authBloc.state;
    if (state is AuthAuthenticated && mounted) {
      // Navigation will be handled by MaterialApp home property update
      // Just trigger rebuild - MaterialApp will show HomePage automatically
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        widget.authBloc.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        widget.authBloc.register(
          _emailController.text.trim(),
          _passwordController.text,
          _nameController.text.trim(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.authBloc.state;
    final isLoading = state is AuthLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Вхід' : 'Реєстрація')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Icon(
                _isLogin ? Icons.login : Icons.person_add,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                _isLogin ? 'Вхід в додаток' : 'Створіть обліковий запис',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (!_isLogin) ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ім\'я',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Введіть ім\'я';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введіть email';
                  }
                  if (!value.contains('@')) {
                    return 'Невірний формат email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть пароль';
                  }
                  if (value.length < 6) {
                    return 'Пароль має бути не менше 6 символів';
                  }
                  return null;
                },
              ),
              if (state is AuthError) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child:
                    isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Text(_isLogin ? 'Увійти' : 'Зареєструватися'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          setState(() {
                            _isLogin = !_isLogin;
                            _formKey.currentState?.reset();
                          });
                        },
                child: Text(
                  _isLogin
                      ? 'Немає облікового запису? Зареєструватися'
                      : 'Вже є обліковий запис? Увійти',
                ),
              ),
              if (_isLogin) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Демо облікові записи:',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                _buildDemoAccount('demo@example.com', 'demo123'),
                const SizedBox(height: 8),
                _buildDemoAccount('test@example.com', 'test123'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoAccount(String email, String password) {
    return OutlinedButton(
      onPressed: () {
        _emailController.text = email;
        _passwordController.text = password;
      },
      child: Text('$email / $password'),
    );
  }
}
