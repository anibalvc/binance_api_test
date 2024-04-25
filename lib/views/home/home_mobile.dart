part of 'home_view.dart';

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vm;

  const _HomeMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ProgressWidget(
          inAsyncCall: vm.loading,
          opacity: false,
          child: Scaffold(
            key: vm.drawerKey,
            drawer: GlobalDrawerDartDesktop(
              notify: () {
                vm.notifyListeners();
              },
            ),
            /* bottomNavigationBar: Container(
              color: AppColors.binanceBlack,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GlobalNavigationBar(index: 0),
            ), */
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    vm.drawerKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vm.isLogged
                        ? Text(
                            "Bienvenido a Binance Test ${vm.usuario.nombrePerfil}",
                            style: AppTextStyle.h1White)
                        : const Text(
                            "Bienvenido a Binance Test",
                            style: AppTextStyle.h1White,
                          ),
                    if (!vm.isLogged)
                      ElevatedButton(
                          onPressed: () {
                            vm.navigator.navigateToPage("login");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.binanceYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Registrarse/Iniciar Sesión",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    Expanded(
                        child: vm.cryptosList.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: vm.cryptosList.length,
                                controller: vm.listController,
                                itemBuilder: (context, i) {
                                  var crypto = vm.cryptosList[i];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: MaterialButton(
                                      onPressed: () =>
                                          vm.moveToCrypto(context, crypto),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35)),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 60,
                                        padding: const EdgeInsets.all(7),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                crypto.symbol,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "\$${crypto.precio.toStringAsFixed(2)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: AppColors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 3, 8, 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: crypto.porcentaje > 0
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              child: Text(
                                                "${crypto.porcentaje.toStringAsFixed(2)}%",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                    if (vm.cryptosList.isNotEmpty) LineChartPrecios()
                  ]),
            ),
          )),
    );
  }
}
