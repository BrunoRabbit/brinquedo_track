import 'package:brinquedo_track/models/daily_sale_model.dart';
import 'package:brinquedo_track/models/highlight_model.dart';
import 'package:brinquedo_track/pages/stats/bloc/stats_bloc.dart';
import 'package:brinquedo_track/widgets/app_toggle_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<DailySaleModel> dailySales = [];

  bool showDaily = false;

  @override
  void initState() {
    super.initState();
    context.read<StatsBloc>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Estatísticas'),
      ),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchedFailed) {
            return Center(
              child: Text(state.error),
            );
          }
          final loaded = state as StatsLoaded;

          return Column(
            children: [
              AppToggleButton(
                labels: ['Top Clientes', 'Vendas Diárias'],
                onTap: (index) {
                  setState(() => showDaily = index == 1);
                },
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.6,
                child: showDaily
                    ? DailySalesChart(dailySales: loaded.dailySales)
                    : HighlightsChart(highlights: loaded.highlights),
              ),
              Expanded(
                child: showDaily
                    ? ListView.builder(
                        itemCount: loaded.dailySales.length,
                        itemBuilder: (context, index) {
                          final sale = loaded.dailySales[index];

                          return ListTile(
                            leading: const Icon(Icons.bar_chart),
                            title: Text(
                              'Data: ${sale.dateFormatted}',
                            ),
                            subtitle: Text(
                              'Total: ${sale.total.toStringAsFixed(2)}',
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: loaded.highlights.length,
                        itemBuilder: (context, index) {
                          final highlight = loaded.highlights[index];
                          return ListTile(
                            leading: const Icon(Icons.star),
                            title: Text(
                              highlight.customer.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email: ${highlight.customer.email}',
                                ),
                                Text(
                                  'Valor: ${highlight.metric.value.toStringAsFixed(2)}',
                                ),
                                Text(
                                  'Tipo: ${highlight.type.name}',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DailySalesChart extends StatelessWidget {
  const DailySalesChart({
    required this.dailySales,
    super.key,
  });

  final List<DailySaleModel> dailySales;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          dailySales.length,
          (i) {
            final sale = dailySales[i];

            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: sale.total,
                  width: 14,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.green,
                ),
              ],
            );
          },
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final data = dailySales[rodIndex];
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(1)}\n${data.dateFormatted}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: const FlTitlesData(
          bottomTitles: AxisTitles(),
          leftTitles: AxisTitles(),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

class HighlightsChart extends StatelessWidget {
  const HighlightsChart({
    required this.highlights,
    super.key,
  });

  final List<HighlightModel> highlights;

  @override
  Widget build(BuildContext context) {
    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < highlights.length; i++) {
      final highlight = highlights[i];

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: highlight.metric.value.toDouble(),
              width: 22,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: List.generate(
          highlights.length,
          (i) {
            final highlight = highlights[i];

            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: highlight.metric.value.toDouble(),
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blueAccent,
                ),
              ],
            );
          },
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toStringAsFixed(1),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();

                if (i < highlights.length) {
                  return Text(
                    highlights[i].customer.name,
                    style: const TextStyle(fontSize: 10),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, _) {
                final label = highlights[value.toInt()].type.name;

                final parts = label.split(' ');
                final formatted = parts.length > 1
                    ? '${parts.first}\n${parts.sublist(1).join(' ')}'
                    : label;

                return Text(
                  formatted,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
