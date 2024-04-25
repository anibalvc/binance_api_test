part of 'detalles_crypto_view.dart';

class _DetallesCryptoMobile extends StatelessWidget {
  final DetallesCryptoViewModel vm;

  const _DetallesCryptoMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ProgressWidget(
          inAsyncCall: vm.loading,
          opacity: false,
          child: Scaffold(
            key: vm.drawerKey,
            /* bottomNavigationBar: Container(
              color: AppColors.binanceBlack,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GlobalNavigationBar(index: 0),
            ), */
            appBar: AppBar(
              centerTitle: true,
              title: Text("${vm.crypto.symbol}/USDT"),
              leading: IconButton(
                  onPressed: () {
                    vm.onDispose(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Precio",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("\$${vm.crypto.precio.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              "Porcentaje de cambio",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: vm.crypto.porcentaje > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Text(
                                  "${vm.crypto.porcentaje.toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Máximo 24h",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("\$${vm.crypto.alto.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              "Cambio de Precio",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "\$${vm.crypto.cambioPrecio.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mínimo 24h",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("\$${vm.crypto.bajo.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              "Volumen 24h",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("\$${vm.crypto.volumen.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    const IndividualChartCrypto(),
                    const SizedBox(
                      height: 20,
                    ),

                    /* Expanded(
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
                                      onPressed: () {},
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
                                })), */
                    //if (vm.cryptosList.isNotEmpty) LineChartPrecios()
                  ]),
            ),
          )),
    );
  }
}
