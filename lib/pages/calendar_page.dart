// import 'package:flutter/material.dart';

// class CalendarPage extends StatefulWidget {
//   const CalendarPage({super.key});

//   @override
//   State<CalendarPage> createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Care',
      debugShowCheckedModeBanner: false,
      home: const CalendarPage(
        userId: 'U-12345',
        userName: 'Abhey Dayal',
      ),
    );
  }
}

// Simple color config
class AppColors {
  static const colorsBlue = Colors.blue;
  static const backgroundLightGrey = Color(0xFFF5F5F7);
  static const fontColor = Colors.black87;
}

class CalendarPage extends StatefulWidget {
  final String userId;
  final String userName;
  final bool isFromSM;

  const CalendarPage({
    super.key,
    required this.userId,
    this.isFromSM = false,
    required this.userName,
  });

  @override
  State<CalendarPage> createState() => _CallAnalyticsState();
}

class _CallAnalyticsState extends State<CalendarPage> {
  String selectedTimeRange = '1D';
  bool _isLoading = false;
  int _selectedIndex = 4;

  // Updated dummy data to match the image exactly
  final Map<String, dynamic> dummyData = {
    "totalConnected": 4,
    "conversationTime": "13M",
    "notConnected": 3,
    "summary": {
      "All Calls": {"calls": 4, "duration": "14", "uniqueClients": 4},
      "Connected": {"calls": 11, "duration": "25", "uniqueClients": 4},
      "Missed": {"calls": 8, "duration": "15", "uniqueClients": 2},
      "Rejected": {"calls": 1, "duration": "1", "uniqueClients": 1},
    },
    "hourlyAnalysis": {
      "9": {"AllCalls": {"calls": 5}, "Connected": {"calls": 3}, "missedCalls": 2},
      "10": {"AllCalls": {"calls": 6}, "Connected": {"calls": 4}, "missedCalls": 2},
      "11": {"AllCalls": {"calls": 8}, "Connected": {"calls": 6}, "missedCalls": 2},
      "12": {"AllCalls": {"calls": 10}, "Connected": {"calls": 8}, "missedCalls": 2},
      "13": {"AllCalls": {"calls": 12}, "Connected": {"calls": 10}, "missedCalls": 2},
      "14": {"AllCalls": {"calls": 15}, "Connected": {"calls": 12}, "missedCalls": 3},
      "15": {"AllCalls": {"calls": 18}, "Connected": {"calls": 15}, "missedCalls": 3},
      "16": {"AllCalls": {"calls": 16}, "Connected": {"calls": 13}, "missedCalls": 3},
      "17": {"AllCalls": {"calls": 14}, "Connected": {"calls": 11}, "missedCalls": 3},
      "18": {"AllCalls": {"calls": 12}, "Connected": {"calls": 9}, "missedCalls": 3},
      "19": {"AllCalls": {"calls": 8}, "Connected": {"calls": 6}, "missedCalls": 2},
      "20": {"AllCalls": {"calls": 6}, "Connected": {"calls": 4}, "missedCalls": 2},
      "21": {"AllCalls": {"calls": 4}, "Connected": {"calls": 2}, "missedCalls": 2},
    }
  };

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _updateSelectedTimeRange(String range) {
    setState(() {
      selectedTimeRange = range;
      _loadDummyData();
    });
  }

  bool get _isTablet => MediaQuery.of(context).size.width > 768;
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  EdgeInsets get _responsivePadding => EdgeInsets.symmetric(
        horizontal: _isTablet ? 20 : (_isSmallScreen ? 12 : 16),
        vertical: _isTablet ? 12 : 8,
      );

  double get _bodyFontSize => _isTablet ? 16 : (_isSmallScreen ? 12 : 14);
  double get _smallFontSize => _isTablet ? 14 : (_isSmallScreen ? 10 : 12);

  List<List<Widget>> get tableData {
    List<List<Widget>> data = [];
    final summary = dummyData['summary'];

    data.add([
      Row(
        children: [
          Icon(Icons.call, size: 16, color: AppColors.colorsBlue),
          const SizedBox(width: 8),
          const Text('All calls', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
      Text(summary['All Calls']['calls'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['All Calls']['duration'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['All Calls']['uniqueClients'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]);

    data.add([
      Row(
        children: [
          Icon(Icons.call, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          const Text('Connected', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
      Text(summary['Connected']['calls'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Connected']['duration'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Connected']['uniqueClients'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]);

    data.add([
      Row(
        children: [
          Icon(Icons.call_missed, size: 16, color: Colors.red),
          const SizedBox(width: 8),
          const Text('Missed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
      Text(summary['Missed']['calls'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Missed']['duration'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Missed']['uniqueClients'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]);

    data.add([
      Row(
        children: [
          Icon(Icons.block, size: 16, color: Colors.red),
          const SizedBox(width: 8),
          const Text('Rejected', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
      Text(summary['Rejected']['calls'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Rejected']['duration'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      Text(summary['Rejected']['uniqueClients'].toString(), 
           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'smart care',
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.w700, 
            color: Color(0xFF1a1a1a)
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        children: [
                          _buildTimeFilterRow(),
                          _buildUserStatsCard(),
                          const SizedBox(height: 16),
                          _buildCallsSummary(),
                          const SizedBox(height: 16),
                          _buildHourlyAnalysis(),
                          const SizedBox(height: 80), // Space for bottom navigation
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
     
    );
  }

Widget _buildTimeFilterRow() {
  final timeRanges = const ['1D', '1W', '1M', '1Q', '1Y'];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(0), // Reduced padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Smaller border radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), 
                blurRadius: 8, 
                offset: const Offset(0, 2)
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: timeRanges.map((r) => _buildTimeFilterChip(r, r == selectedTimeRange)).toList(),
          ),
        ),
      ],
    ),
  );

}Widget _buildTimeFilterChip(String label, bool isActive) {
  return GestureDetector(
    onTap: () => _updateSelectedTimeRange(label),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6.5),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE0E7FF) : Colors.transparent, // Light purple background for active
        border: isActive ? Border.all(
          color: const Color(0xFF6366F1), // Purple stroke/border for active tab
          width: 1.5,
        ) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF6366F1) : const Color(0xFF6B7280),
        ),
      ),
    ),
  );
}
Widget _buildUserStatsCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08), 
          blurRadius: 12, 
          offset: const Offset(0, 4)
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Name and Target row - ensure proper spacing and visibility
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                widget.userName,
                style: const TextStyle(                
                  fontFamily: 'Montserrat', // From your specs
                  fontSize: 24,             // 24px from specs
                  fontWeight: FontWeight.w400, // Regular (400)
                  color: Color(0xFF000000),    // Black (#000000)
                  height: 1.0,              // 100% line height
                  letterSpacing: 0,      
                ),
                overflow: TextOverflow.ellipsis, // Handle long names
              ),
            ),
            const SizedBox(width: 8), // Add some spacing
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEBFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Target : 30', 
                style: TextStyle(
                   fontFamily: 'Montserrat',
                  fontSize: 12, 
                  fontWeight: FontWeight.w400, 
                  color: Colors.black87, // Changed to black87 for better visibility
                )
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(   
          
          children: [
            Expanded(
              child: _buildStatItem(  
                value: dummyData['totalConnected'].toString(),
                label: 'Total\nConnected',
                icon: Icons.call,
                color: Colors.green,
                
              ),
            ), 
            Container(margin: EdgeInsets.only(  right: 10),
              width: 1.2, height: 41, color: Colors.grey[300]),  
            Expanded(
              child: _buildStatItem(
                
                value: dummyData['conversationTime'].toString(),
                label: 'Conversation\ntime',
                icon: Icons.access_time,
               color: Color(0xFF53518B),
               fontWeight: FontWeight.w500,
              ),
            ), 
            Container(width: 1.2, height: 41, color: Colors.grey[300],margin: EdgeInsets.only(  right: 10)),
             
            Expanded(
              child: _buildStatItem(
                value: dummyData['notConnected'].toString(),
                label: 'Not\nConnected',
                icon: Icons.call_missed,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
    FontWeight? fontWeight,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width:15),
            Icon(icon, size: 20, color: color),
          ],
        ),
        const SizedBox(height: 12),
        
     
        Row(
          children: [
            Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(
                 fontFamily: 'poppin',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCallsSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), 
            blurRadius: 12, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: _buildAnalyticsTable(),
    );
  }

  Widget _buildAnalyticsTable() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2.2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1.2),
        },
        children: [
          TableRow(
            children: [
              const SizedBox(),
              _buildHeaderCell('Calls'),
              _buildHeaderCell('Duration'),
              _buildHeaderCell('Unique\nClient'),
            ],
          ),
          ...tableData.map((row) => TableRow(
            children: row.map((cell) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: cell,
            )).toList(),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildHourlyAnalysis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), 
            blurRadius: 12, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Hourly Analysis',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                    child: _buildChart(),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: _buildFloatingSummaryCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow('All calls', '10', '6 min 39 secs'),
          const SizedBox(height: 4),
          _buildSummaryRow('Connected', '3', '3 min 02 secs'),
          const SizedBox(height: 4),
          _buildSummaryRow('Missed calls', '5', '2 secs'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String count, String duration) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          count,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          duration,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    const Color primaryPurple = Color(0xFF8B5CF6);
    const Color lightPurple = Color(0xFFE9D5FF);
    const Color fillColor = Color(0xFFF3E8FF);

    final Map ha = dummyData['hourlyAnalysis'];
    final hours = List.generate(13, (i) => i + 9);

    final List<FlSpot> allCallsSpots = [];
    final List<FlSpot> connectedSpots = [];
    final List<FlSpot> missedSpots = [];

    for (int i = 0; i < hours.length; i++) {
      final key = hours[i].toString();
      final data = ha[key] ?? {};
      
      allCallsSpots.add(FlSpot(i.toDouble(), (data['AllCalls']?['calls'] ?? 0).toDouble()));
      connectedSpots.add(FlSpot(i.toDouble(), (data['Connected']?['calls'] ?? 0).toDouble()));
      missedSpots.add(FlSpot(i.toDouble(), (data['missedCalls'] ?? 0).toDouble()));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xFFE5E7EB),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (hours.length - 1).toDouble(),
        minY: 0,
        maxY: 20,
        extraLinesData: ExtraLinesData(
          verticalLines: [
            VerticalLine(
              x: 6, // Around 3PM position
              color: const Color(0xFF9CA3AF).withOpacity(0.5),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ],
        ),
        lineBarsData: [
          // Background filled area
          LineChartBarData(
            spots: allCallsSpots,
            isCurved: true,
            color: lightPurple,
            barWidth: 0,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: fillColor,
            ),
          ),
          // Main line
          LineChartBarData(
            spots: allCallsSpots,
            isCurved: true,
            color: primaryPurple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          ),
          // Connected line
          LineChartBarData(
            spots: connectedSpots,
            isCurved: true,
            color: primaryPurple.withOpacity(0.7),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          ),
          // Missed calls line
          LineChartBarData(
            spots: missedSpots,
            isCurved: true,
            color: primaryPurple.withOpacity(0.5),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }}

