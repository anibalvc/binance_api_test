import 'dart:convert';

import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/views/graficos/volumen/volumen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:iconamoon/iconamoon.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

class GlobalDrawerDartDesktop extends StatelessWidget {
  GlobalDrawerDartDesktop({super.key, required this.notify});

  final _navigationService = locator<NavigatorService>();
  final _autenticationClient = locator<AuthenticationClient>();

  final getIt = GetIt.instance;
  final void Function() notify;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.binanceBlack,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(25))),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.binanceBlack,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                  )),
              height: size.height * .27,
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  if (_autenticationClient.isLogged) ...[
                    _autenticationClient.loadUsuario.imgPerfil.isNotEmpty
                        ? Positioned(
                            top: size.width > 370 ? 30 : 10,
                            child: Image.memory(
                              base64Decode(
                                  _autenticationClient.loadUsuario.imgPerfil),
                              width: 70,
                              height: 70,
                              gaplessPlayback: true,
                            ),
                          )
                        : Positioned(
                            top: 10,
                            child: SvgPicture.asset(
                              "assets/icons/user-circle.svg",
                              height: 80,
                              width: 80,
                              color: Colors.white,
                            ),
                          ),
                    Positioned(
                      top: size.width > 370 ? 90 : 70,
                      child: TextButton(
                          child: Text(
                            _autenticationClient.loadUsuario.nombrePerfil,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                          onPressed: () {
                            _navigationService
                                .navigateToPageAndRemoveUntil("perfil");
                          }),
                    ),
                    Positioned(
                      top: size.width > 370 ? 130 : 110,
                      child: ElevatedButton(
                          onPressed: () {
                            _navigationService
                                .navigateToPageAndRemoveUntil("home");
                            _autenticationClient.clear();
                            notify();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.binanceYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Cerrar Sesión",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    )
                  ] else ...[
                    Positioned(
                      top: size.width > 370 ? 30 : 10,
                      child: SvgPicture.asset(
                        "assets/icons/user-circle.svg",
                        height: 80,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: size.width > 370 ? 130 : 110,
                      child: ElevatedButton(
                          onPressed: () {
                            _navigationService.navigateToPage("login");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.binanceYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    )
                  ]
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  /* Opciones del menu */
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        title: const Text(
                          'Gráfica de Volumen',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                        leading: const Icon(
                          IconaMoon.news,
                          color: AppColors.white,
                          size: 45,
                        ),
                        onTap: () {
                          _navigationService
                              .navigateToPage(VolumenView.routeName);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "© 2024 Binance-Test - App v1.0",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
