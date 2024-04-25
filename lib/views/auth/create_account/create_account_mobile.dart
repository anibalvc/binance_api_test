part of 'create_account_view.dart';

class _CreateAccountMobile extends StatelessWidget {
  final CreateAccountViewModel vm;

  const _CreateAccountMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ProgressWidget(
        inAsyncCall: vm.loading,
        child: CreateAccountPageWidget(
          child: Form(
            key: vm.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                AppTextField(
                  text: 'Usuario',
                  controller: vm.tcNombreUsuario,
                  keyboardType: TextInputType.emailAddress,
                  validator: (pass) {
                    if (pass!.trim().length < 3) {
                      return 'Usuario inválido';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  text: 'Nombre de Perfil',
                  controller: vm.tcNombrePerfil,
                  keyboardType: TextInputType.emailAddress,
                  validator: (pass) {
                    if (pass!.trim().length < 3) {
                      return 'Nombre de Perfil inválido';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  text: 'Correo',
                  controller: vm.tcCorreo,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    return emailValidator(email);
                  },
                ),
                const SizedBox(height: 10),
                AppTextField(
                  text: 'Contraseña',
                  validator: (pass) {
                    return passwordValidator(pass);
                  },
                  controller: vm.tcPassword,
                  obscureText: vm.obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  iconButton: AppObscureTextIcon(
                    icon: vm.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPressed: vm.changeObscure,
                  ),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  text: 'Repita la Contraseña',
                  validator: (pass) {
                    if (vm.tcPassword.text != vm.tcPassword2.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                  controller: vm.tcPassword2,
                  obscureText: vm.obscurePassword2,
                  keyboardType: TextInputType.visiblePassword,
                  iconButton: AppObscureTextIcon(
                    icon: vm.obscurePassword2
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPressed: vm.changeObscure2,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => _showTermsAndConditionsDialog(context),
                  child: const Text(
                    'Por favor, lee y acepta los Términos y Condiciones',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.black,
                      ),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: Checkbox(
                            value: vm.checked,
                            onChanged: (value) {
                              vm.checkTerminos();
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => vm.checkTerminos(),
                      child: const Text(
                        'Acepto los Términos y Condiciones',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AppButtonLogin(
                  text: 'Crear',
                  textColor: Colors.black,
                  onPressed: () => vm.createAccount(context),
                  color: AppColors.binanceYellow,
                ),

                // InkWell(
                // onTap: () => vm.goToConfigPassword(),
                // child:

                // color: AppColors.orange,

                /* AppButtonLogin(
                  text: 'Recuperar contraseña',
                  onPressed: () => vm.goToRecoveryPassword(),
                  color: AppColors.white,
                  textColor: Colors.black,
                  borderColor: AppColors.black,
                ) */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showTermsAndConditionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const SingleChildScrollView(
          child: Text(
            """ACUERDO DE TÉRMINOS Y CONDICIONES DE LA APLICACIÓN MÓVIL
Este Acuerdo de Términos y Condiciones ("Acuerdo") rige el uso de la aplicación móvil (en adelante "Aplicación") proporcionada por Binance Test ("Nosotros" o "Proveedor") y el usuario de la Aplicación ("Tú" o "Usuario").
1. Aceptación de los Términos y Condiciones
Al descargar, instalar o utilizar la Aplicación, aceptas y estás de acuerdo con los términos y condiciones establecidos en este Acuerdo. Si no estás de acuerdo con estos términos, por favor no utilices la Aplicación.
2. Uso de la Aplicación
2.1. Licencia de Uso: Con sujeción a los términos y condiciones de este Acuerdo, otorgamos al Usuario una licencia limitada, no exclusiva, no transferible y revocable para utilizar la Aplicación con fines personales y no comerciales en un dispositivo móvil que poseas o controles.
2.2. Restricciones de Uso: No puedes:
a. Copiar, modificar, distribuir o crear trabajos derivados basados en la Aplicación.
b. Descompilar, realizar ingeniería inversa o intentar acceder al código fuente de la Aplicación.
c. Realizar actividades ilegales o que violen los derechos de terceros a través de la Aplicación.
3. Contenido de la Aplicación
3.1. Propiedad del Contenido: Todos los derechos de propiedad intelectual en la Aplicación y su contenido (textos, gráficos, logotipos, imágenes, videos, etc.) son propiedad de [Tu Nombre o Nombre de la Empresa] y están protegidos por las leyes de derechos de autor y otras leyes aplicables.
3.2. Contenido Generado por el Usuario: Al cargar o compartir contenido a través de la Aplicación, garantizas que tienes el derecho legal de hacerlo y otorgas a Binance Test una licencia no exclusiva para utilizar ese contenido.
4. Privacidad y Datos Personales
4.1. Privacidad: Tu uso de la Aplicación está sujeto a nuestra Política de Privacidad. Al utilizar la Aplicación, aceptas las prácticas de privacidad establecidas en la Política de Privacidad.
5. Modificaciones y Terminación
5.1. Modificaciones: Nos reservamos el derecho de modificar o interrumpir la Aplicación en cualquier momento. Notificaremos a los Usuarios sobre cambios significativos en la Aplicación o en este Acuerdo.
5.2. Terminación: Podemos, a nuestra sola discreción, dar por terminado tu acceso a la Aplicación en cualquier momento, con o sin motivo.
6. Responsabilidad y Garantía
6.1. Sin Garantía: La Aplicación se proporciona "tal cual" y "según disponibilidad". No ofrecemos garantías expresas o implícitas con respecto a la Aplicación, incluyendo garantías de comerciabilidad, idoneidad para un propósito particular y no violación.
6.2. Limitación de Responsabilidad: En ningún caso seremos responsables de daños directos, indirectos, incidentales, especiales o consecuentes que surjan del uso o incapacidad de uso de la Aplicación.
7. Ley Aplicable
7.1. Este Acuerdo se rige por las leyes Venezolanas, y se somete a la jurisdicción exclusiva de los tribunales de Nueva Esparta.
8. Contacto
Para preguntas o comentarios sobre este Acuerdo, contáctanos al correo Anibalvc1999@gmail.com.
Al aceptar estos términos y condiciones, confirmas que los has leído y comprendido. Este Acuerdo entra en vigencia en la fecha de tu primera utilización de la Aplicación.
Binance Test 23 de Abril de 2024
""",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
