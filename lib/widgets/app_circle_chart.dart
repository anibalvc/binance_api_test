import 'dart:math';

import 'package:binance_api_test/core/providers/precios_cryptos_provider.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/app_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleChart extends StatefulWidget {
  const CircleChart({super.key});

  @override
  State<StatefulWidget> createState() => CircleChartState();
}

class CircleChartState extends State {
  int touchedIndex = -1;
  int colors = 0;
  late Color baseColor;
  late Map<String, Color> coloresCrypto = {};

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            const Text(
              "Volumen de Criptomonedas Base",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: partesVolumenBase(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: coloresCrypto.entries.map((entry) {
                    String colorName = entry.key;
                    Color colorValue = entry.value;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: colorValue,
                          text: colorName,
                          isSquare: true,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
            const Text(
              "Volumen de Criptomonedas Cotizadas",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: partesVolumenCotizacion(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: coloresCrypto.entries.map((entry) {
                    String colorName = entry.key;
                    Color colorValue = entry.value;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: colorValue,
                          text: colorName,
                          isSquare: true,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> partesVolumenBase() {
    var providerPreciosCryptos =
        Provider.of<PreciosCryptosProvider>(context, listen: false);
    var cryptos = providerPreciosCryptos.cryptos;
    List<PieChartSectionData> parts = [];
    double totalVolume = cryptos
        .map((crypto) => crypto.volumen)
        .reduce((value, element) => value + element);
    const double minPercentage = 3.0; // Valor mínimo del porcentaje
    List<PieChartSectionData> smallParts =
        []; // Lista de partes pequeñas agrupadas

    for (var element in cryptos) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double porcentaje = (element.volumen / totalVolume) * 100;
      Random random = Random();
      Color color = getRandomDarkPastelColor(random);
      if (colors == 0) {
        coloresCrypto[element.symbol] = color;
      }

      // Si el porcentaje es menor que el valor mínimo, se agrega a la lista de partes pequeñas agrupadas
      if (porcentaje < minPercentage) {
        smallParts.add(PieChartSectionData(
          color: coloresCrypto[element.symbol],
          value: porcentaje,
          title: "${porcentaje.round()}%",
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ));
      } else {
        parts.add(PieChartSectionData(
          color: coloresCrypto[element.symbol],
          value: porcentaje,
          title: "${porcentaje.round()}%",
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ));
      }
    }

    // Se crea una sola parte al final de la lista
    if (smallParts.isNotEmpty) {
      double totalSmallPercentage =
          smallParts.map((part) => part.value).reduce((a, b) => a + b);
      parts.add(PieChartSectionData(
        color: Colors.grey, // Color para las partes pequeñas agrupadas
        value: totalSmallPercentage,
        title: "Otros", // Título para las partes pequeñas agrupadas
        radius: 50.0,
        titleStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ));
    }

    colors = 1;
    return parts;
  }

  List<PieChartSectionData> partesVolumenCotizacion() {
    var providerPreciosCryptos =
        Provider.of<PreciosCryptosProvider>(context, listen: false);
    var cryptos = providerPreciosCryptos.cryptos;
    List<PieChartSectionData> parts = [];
    double totalVolume = cryptos
        .map((crypto) => crypto.volumenCuota)
        .reduce((value, element) => value + element);
    const double minPercentage = 3.0; // Valor mínimo del porcentaje
    List<PieChartSectionData> smallParts =
        []; // Lista de partes pequeñas agrupadas

    for (var element in cryptos) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double porcentaje = (element.volumenCuota / totalVolume) * 100;
      Random random = Random();
      Color color = getRandomDarkPastelColor(random);
      if (colors == 0) {
        coloresCrypto[element.symbol] = color;
      }

      // Si el porcentaje es menor que el valor mínimo, se agrega a la lista de partes pequeñas agrupadas
      if (porcentaje < minPercentage) {
        smallParts.add(PieChartSectionData(
          color: coloresCrypto[element.symbol],
          value: porcentaje,
          title: "${porcentaje.round()}%",
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ));
      } else {
        parts.add(PieChartSectionData(
          color: coloresCrypto[element.symbol],
          value: porcentaje,
          title: "${porcentaje.round()}%",
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ));
      }
    }

    // Se crea una sola parte al final de la lista
    if (smallParts.isNotEmpty) {
      double totalSmallPercentage =
          smallParts.map((part) => part.value).reduce((a, b) => a + b);
      parts.add(PieChartSectionData(
        color: Colors.grey, // Color para las partes pequeñas agrupadas
        value: totalSmallPercentage,
        title: "Otros", // Título para las partes pequeñas agrupadas
        radius: 50.0,
        titleStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ));
    }

    colors = 1;
    return parts;
  }

  Color getRandomDarkPastelColor(Random random) {
    int minComponentValue = 100; // Asegura que los colores sean oscuros
    int maxComponentValue =
        150; // Ajusta según tus preferencias para tonos pasteles

    // Genera valores aleatorios dentro del rango especificado
    int red = minComponentValue +
        random.nextInt(maxComponentValue - minComponentValue);
    int green = minComponentValue +
        random.nextInt(maxComponentValue - minComponentValue);
    int blue = minComponentValue +
        random.nextInt(maxComponentValue - minComponentValue);

    // Crea y devuelve el color aleatorio
    return Color.fromARGB(255, red, green, blue);
  }
}
