import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      title: 'Taller Login',
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final emailController = TextEditingController();
  final claveController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  void handleLogin() {
    if (emailController.text.isEmpty || claveController.text.isEmpty) {
      print('Por favor ingrese su correo y contraseña.');      
    } else {
      print('Botón Ingresar presionado. Acceso concedido.');
    }
  }

  void handleRegister() {
    print('Registrar nuevo usuario, será redireccionado a una nueva ventana.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1.02,
              heightFactor: 0.7,
              child: Card(
                elevation: 50,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Credentials',
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _textCustom(
                          context,
                          label: 'Email',
                          font: 'Montserrat',
                        ),
                        const SizedBox(height: 10),
                        _buildInputField(
                          context,
                          controller: emailController,
                          hintText: 'ejemplo@gmail.com',
                          icon: Icons.mail,
                        ),
                        const SizedBox(height: 30),
                        _textCustom(
                          context,
                          label: 'Clave',
                          font: 'Montserrat',
                        ),
                        const SizedBox(height: 10),
                        _buildInputField(context,
                            controller: claveController,
                            hintText: '*************',
                            icon: Icons.lock,
                            isPassword: true,
                            showPassword: showPassword,
                            togglePasswordVisibility: () {
                          setState(() => showPassword = !showPassword);
                        }),
                        const SizedBox(height: 30),
                        _buildButton(
                          context,
                          buttonText: "Ingresar ",
                          onPressed: handleLogin,
                        ),
                        const SizedBox(height: 20),
                        _buildButton(
                          context,
                          buttonText: "Registrarse ",
                          onPressed: handleRegister,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _textCustom(
  BuildContext context, {
  required String label,
  required String font,
}) {
  return Text(
    label,
    style: GoogleFonts.getFont(
      font,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Colors.black87,
    ),
  );
}

Widget _buildInputField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  bool showPassword = false,
  VoidCallback? togglePasswordVisibility,
}) {
  final colors = Theme.of(context).colorScheme;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colors.primary),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword && !showPassword,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: colors.primary),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: colors.primary,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget _buildButton(
  BuildContext context, {
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.outfit(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
