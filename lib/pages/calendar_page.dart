

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
 const CalendarPage({super.key});

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
 "9": {
 "AllCalls": {"calls": 5},
 "Connected": {"calls": 3},
 "missedCalls": 2,
 },
 "10": {
 "AllCalls": {"calls": 6},
 "Connected": {"calls": 4},
 "missedCalls": 2,
 },
 "11": {
 "AllCalls": {"calls": 8},
 "Connected": {"calls": 6},
 "missedCalls": 2,
 },
 "12": {
 "AllCalls": {"calls": 10},
 "Connected": {"calls": 8},
 "missedCalls": 2,
 },
 "13": {
 "AllCalls": {"calls": 12},
 "Connected": {"calls": 10},
 "missedCalls": 2,
 },
 "14": {
 "AllCalls": {"calls": 15},
 "Connected": {"calls": 12},
 "missedCalls": 3,
 },
 "15": {
 "AllCalls": {"calls": 18},
 "Connected": {"calls": 15},
 "missedCalls": 3,
 },
 "16": {
 "AllCalls": {"calls": 16},
 "Connected": {"calls": 13},
 "missedCalls": 3,
 },
 "17": {
 "AllCalls": {"calls": 14},
 "Connected": {"calls": 11},
 "missedCalls": 3,
 },
 "18": {
 "AllCalls": {"calls": 12},
 "Connected": {"calls": 9},
 "missedCalls": 3,
 },
 "19": {
 "AllCalls": {"calls": 8},
 "Connected": {"calls": 6},
 "missedCalls": 2,
 },
 "20": {
 "AllCalls": {"calls": 6},
 "Connected": {"calls": 4},
 "missedCalls": 2,
 },
 "21": {
 "AllCalls": {"calls": 4},
 "Connected": {"calls": 2},
 "missedCalls": 2,
 },
 },
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

  // All calls row
  data.add([
    Row(
      children: [
        Icon(Icons.call, size: 16, color: AppColors.colorsBlue),
        const SizedBox(width: 8),
        Text(
          textAlign: TextAlign.center,
          'All calls',
          style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['All Calls']['calls'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['All Calls']['duration'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['All Calls']['uniqueClients'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
  ]);

  // Connected row
  data.add([
    Row(
      children: [
        Icon(Icons.call, size: 16, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          textAlign: TextAlign.center,
          'Connected',
          style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Connected']['calls'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Connected']['duration'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Connected']['uniqueClients'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
  ]);

  // Missed row
data.add([
  Row(
    children: [
      SvgPicture.asset(
        'assets/your_missed_icon.svg',
        width: 14,
        height: 14,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
      const SizedBox(width: 15),
      Text(
        'Missed',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  ),
  Padding(
    padding: const EdgeInsets.only(left: 14),
    child: Text(
      textAlign: TextAlign.left,
      summary['Missed']['calls'].toString(),
      style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
    ),
  ),
  Padding(
    padding: const EdgeInsets.only(left: 14),
    child: Text(
      textAlign: TextAlign.left,
      summary['Missed']['duration'].toString(),
      style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
    ),
  ),
  Padding(
    padding: const EdgeInsets.only(left: 14),
    child: Text(
      textAlign: TextAlign.left,
      summary['Missed']['uniqueClients'].toString(),
      style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
    ),
  ),
]);

  // Rejected row
  data.add([
    Row(
      children: [
        Icon(Icons.block, size: 16, color: Colors.red),
        const SizedBox(width: 8),
        Text(
          'Rejected',
          style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Rejected']['calls'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Rejected']['duration'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        textAlign: TextAlign.left,
        summary['Rejected']['uniqueClients'].toString(),
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    ),
  ]);
  return data;
}

 @override
 Widget build(BuildContext context) {
 return Scaffold(
 backgroundColor: AppColors.white,
 appBar: AppBar(
 backgroundColor: Colors.white,
 elevation: 0,
 automaticallyImplyLeading: false,
title: Text(
  'smart care',
  style: GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 24,
     color: const Color(0xFF212E51),
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
 constraints: BoxConstraints(
 minHeight: constraints.maxHeight,
 ),
 child: Column(
 children: [
 _buildTimeFilterRow(),
 _buildUserStatsCard(),
 const SizedBox(height: 16),
 _buildCallsSummary(),
 const SizedBox(height: 16),
 _buildHourlyAnalysis(),
 const SizedBox(
 height: 80,
 ), // Space for bottom navigation
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
 offset: const Offset(0, 2),
 ),
 ],
 ),
 child: Row(
 mainAxisSize: MainAxisSize.min,
 children: timeRanges
 .map((r) => _buildTimeFilterChip(r, r == selectedTimeRange))
 .toList(),
 ),
 ),
 ],
 ),
 );
 }

 Widget _buildTimeFilterChip(String label, bool isActive) {
 return GestureDetector(
 onTap: () => _updateSelectedTimeRange(label),
 child: Container(
 padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6.5),
 decoration: BoxDecoration(
 color: isActive
 ? const Color(0xFFE0E7FF)
 : Colors.transparent, // Light purple background for active
 border: isActive
 ? Border.all(
 color: const Color.fromARGB(255, 112, 108, 187), // Purple stroke/border for active tab
 width: 1.5,
 )
 : null,
 borderRadius: BorderRadius.circular(16),
 ),
 child: Text(
 label,
 style: TextStyle(
 fontSize: 10,
 fontWeight: FontWeight.w600,
 color: isActive ?const Color.fromARGB(255, 111, 106, 189) : const Color(0xFF6B7280),
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
 offset: const Offset(0, 4),
 ),
 ],
 ),
 child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 mainAxisAlignment: MainAxisAlignment.spaceAround,
 children: [
 Row(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
 crossAxisAlignment: CrossAxisAlignment.center,
 children: [
 Flexible(
 child: Text(
 'Abhey Dayal',
 style: const TextStyle(
 fontFamily: 'Montserrat', // From your specs
 fontSize: 24, // 24px from specs
 fontWeight: FontWeight.w400, // Regular (400)
 color: Color(0xFF000000), // Black (#000000)
 height: 1.0, // 100% line height
 letterSpacing: 0,
 ),
 overflow: TextOverflow.ellipsis, // Handle long names
 ),
 ),
 // const SizedBox(width: 8), // Add some spacing
 Container(
 padding: const EdgeInsets.symmetric(
 horizontal: 12,
 vertical: 6,
 ),
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
 color: Colors
 .black87, // Changed to black87 for better visibility
 ),
 ),
 ),
 ],
 ),

 const SizedBox(height: 14),
 Row(
 mainAxisAlignment: MainAxisAlignment.spaceAround,
 children: [
 _buildStatItem(
 value: dummyData['totalConnected'].toString(),
 label: 'Total\nConnected',
 icon: Icons.call,
 color: Colors.green,
 ),

 Container(width: 1.2, height: 41, color: Colors.grey[300]),

 _buildStatItem(
 value: dummyData['conversationTime'].toString(),
 label: 'Conversation\ntime',
 icon: Icons.access_time,
 color: const Color(0xFF53518B),
 fontWeight: FontWeight.w500,
 ),

 Container(width: 1.2, height: 41, color: Colors.grey[300]),

 _buildStatItem(
 value: dummyData['notConnected'].toString(),
 label: 'Not\nConnected',
svgPath: 'assets/your_missed_icon.svg',
 color: Colors.red,
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
  IconData? icon,            // 👈 Optional Material icon
  String? svgPath,           // 👈 Optional SVG path
  required Color color,
  FontWeight? fontWeight,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          if (svgPath != null) ...[
            SvgPicture.asset(
              svgPath,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          ] else if (icon != null) ...[
            Icon(icon, size: 20, color: color),
          ]
        ],
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontFamily: 'poppin',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B7280),
        ),
      ),
    ],
  );
}

 // Widget _buildStatItem({
 // required String value,
 // required String label,
 // required IconData icon,
 // required Color color,
 // FontWeight? fontWeight,
 // }) {
 // return Column(
 // children: [
 // Row(
 // children: [
 // Container(
 // decoration: BoxDecoration(
 // border: Border.all(color: Colors.black),
 // ),
 // child: Text(
 // value,
 // style: GoogleFonts.montserrat(
 // fontSize: 24,
 // fontWeight: FontWeight.w600,
 // color: color,
 // ),
 // ),
 // ),
 // // const SizedBox(width: 15),
 // Icon(icon, size: 20, color: color),
 // ],
 // ),

 // const SizedBox(height: 12),
 // Row(
 // children: [
 // Text(
 // label,
 // textAlign: TextAlign.start,
 // style: const TextStyle(
 // fontFamily: 'poppin',
 // fontSize: 13,
 // fontWeight: FontWeight.w400,
 // color: Color(0xFF6B7280),
 // height: 1.2,
 // ),
 // ),
 // ],
 // ),
 // ],
 // );
 // }

Widget _buildCallsSummary() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Color(0xFF9C8DF6), // Purple background
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "Enquiry Summary",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildAnalyticsTable(), // your table
      ],
    ),
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
 ...tableData
 .map(
 (row) => TableRow(
 children: row
 .map(
 (cell) => Padding(
 padding: const EdgeInsets.symmetric(
 vertical: 8.7,
 horizontal: 2,
 ),
 child: cell,
 ),
 )
 .toList(),
 ),
 )
 .toList(),
 ],
 ),
 );
 }

  Widget _buildHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
            padding: EdgeInsets.fromLTRB(32, 15, 15, 0),
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
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: _buildChart(),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 25,
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
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 16,
          offset: const Offset(0, 8),
        )
      ],
    ),
    width: 240, // Increased width for wider boxes
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _floatingSummaryRow(
          label: "All calls",
          value: "10",
          duration: "6 min 39 secs",
        ),
        const SizedBox(height: 6,),
        _floatingSummaryRow(
          label: "Connected",
          value: "3",
          duration: "3 min 02 secs",
        ),
        const SizedBox(height: 6),
        _floatingSummaryRow(
          label: "Missed calls",
          value: "5",
          duration: "2 secs",
        ),
      ],
    ),
  );
}

Widget _floatingSummaryRow({
  required String label,
  required String value,
  required String duration,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 6,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
            height: 1.4,
            letterSpacing: 0.3,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
          softWrap: true,
        ),
      ),
      Container(
        width: 25,
        alignment: Alignment.center,  // Center horizontally and vertically
        child: Text(
          value,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.4,
            letterSpacing: 0.3,
            overflow: TextOverflow.clip,
          ),
          maxLines: 1,
          softWrap: true,
          textAlign: TextAlign.center,  // Center text horizontally
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        flex: 9,
        child: Text(
          duration,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.4,
            letterSpacing: 0.9,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
          softWrap: true,
          textAlign: TextAlign.right,
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
              showTitles: false,
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

