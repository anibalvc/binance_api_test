part of 'volumen_view.dart';

class _VolumenMobile extends StatelessWidget {
  final VolumenViewModel vm;

  const _VolumenMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ProgressWidget(
          inAsyncCall: vm.loading,
          opacity: false,
          child: Scaffold(
            key: vm.drawerKey,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Volumen de Cryptomonedas"),
            ),
            body: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleChart(),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          )),
    );
  }
}
