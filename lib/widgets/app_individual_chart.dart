import 'package:binance_api_test/core/providers/detalle_crypto_provider.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndividualChart extends StatelessWidget {
  const IndividualChart({super.key});

  @override
  Widget build(BuildContext context) {
    var providerDetallesCrypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false);
    return BarChart(
      BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: providerDetallesCrypto.last10,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: providerDetallesCrypto.crypto.precio * 1.001,
          minY: providerDetallesCrypto.crypto.precio * .999),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: const EdgeInsets.only(right: 5),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(2),
              const TextStyle(
                color: AppColors.binanceYellow,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );
}

class IndividualChartCrypto extends StatefulWidget {
  const IndividualChartCrypto({super.key});

  @override
  State<StatefulWidget> createState() => IndividualChartCryptoState();
}

class IndividualChartCryptoState extends State<IndividualChartCrypto> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1,
      child: IndividualChart(),
    );
  }
}
