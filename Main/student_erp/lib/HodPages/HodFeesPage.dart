import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(HODFeesPage());
}

class HODFeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOD Fees Dashboard'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Add profile functionality here
              },
            ),
          ],
        ),
        body: FeesDashboard(),
      ),
    );
  }
}

class FeesDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardCard(
              title: 'Fees Overview',
              widgets: [
                StatWidget(
                  label: 'Fully Paid',
                  count: 300,
                  countColor: Colors.green,
                  onStatClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentStatusPage(status: 'Fully Paid'),
                      ),
                    );
                  },
                ),
                StatWidget(
                  label: 'Partially Paid',
                  count: 150,
                  countColor: Colors.orange,
                  onStatClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentStatusPage(status: 'Partially Paid'),
                      ),
                    );
                  },
                ),
                StatWidget(
                  label: 'Not Paid',
                  count: 50,
                  countColor: Colors.red,
                  onStatClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentStatusPage(status: 'Not Paid'),
                      ),
                    );
                  },
                ),
              ],
              onMoreDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YearSelectionPage()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PaymentStatusPage extends StatelessWidget {
  final String status;

  PaymentStatusPage({required this.status});

  final List<Map<String, dynamic>> students = List.generate(30, (index) {
    return {
      'name': 'Student ${index + 1}',
      'rollNo': 'REG${index + 1}',
      'status': index % 2 == 0
          ? 'Fully Paid'
          : (index % 3 == 0 ? 'Partially Paid' : 'Not Paid'),
    };
  });

  @override
  Widget build(BuildContext context) {
    final filteredStudents =
        students.where((student) => student['status'] == status).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$status Students'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: filteredStudents.length,
        itemBuilder: (context, index) {
          final student = filteredStudents[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(student['name']),
              subtitle: Text('Roll No: ${student['rollNo']}'),
            ),
          );
        },
      ),
    );
  }
}

class YearSelectionPage extends StatelessWidget {
  final List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Year'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(years[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SectionSelectionPage(year: years[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionSelectionPage extends StatelessWidget {
  final String year;
  final List<String> sections = ['Section A', 'Section B', 'Section C'];

  SectionSelectionPage({required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Section for $year'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(sections[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionFeesDetails(
                        year: year,
                        section: sections[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionFeesDetails extends StatelessWidget {
  final String year;
  final String section;

  SectionFeesDetails({required this.year, required this.section});

  final List<Map<String, dynamic>> students = List.generate(30, (index) {
    return {
      'name': 'Student ${index + 1}',
      'rollNo': 'REG${index + 1}',
      'totalFees': 50000,
      'paidFees': index % 2 == 0 ? 50000 : (index % 3 == 0 ? 25000 : 0),
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$section - $year Fees Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = generatePDF();
              await Printing.layoutPdf(onLayout: (format) => pdf.save());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final balance = student['totalFees'] - student['paidFees'];
          final statusColor = student['paidFees'] == student['totalFees']
              ? Colors.green
              : student['paidFees'] > 0
                  ? Colors.orange
                  : Colors.red;

          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(student['name']),
              subtitle: Text('Roll No: ${student['rollNo']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Paid: ${student['paidFees']}'),
                  Text(
                    'Balance: $balance',
                    style: TextStyle(color: statusColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  pw.Document generatePDF() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              final balance = student['totalFees'] - student['paidFees'];
              final statusColor = student['paidFees'] == student['totalFees']
                  ? Colors.green
                  : student['paidFees'] > 0
                      ? Colors.orange
                      : Colors.red;

              return pw.Container(
                padding: const pw.EdgeInsets.all(8.0),
                margin: const pw.EdgeInsets.symmetric(vertical: 4.0),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: Colors.grey),
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Name: ${student['name']}',
                            style: pw.TextStyle(fontSize: 14)),
                        pw.Text('Roll No: ${student['rollNo']}',
                            style: pw.TextStyle(fontSize: 14)),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Paid: ₹${student['paidFees']}',
                            style: pw.TextStyle(fontSize: 14)),
                        pw.Text(
                          'Balance: ₹$balance',
                          style: pw.TextStyle(color: statusColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    return pdf;
  }
}

class Printing {
  static layoutPdf({required Function(dynamic format) onLayout}) {}
}

class PdfColors {}

class DashboardCard extends StatelessWidget {
  final String title;
  final List<StatWidget> widgets;
  final VoidCallback onMoreDetailsPressed;

  DashboardCard({
    required this.title,
    required this.widgets,
    required this.onMoreDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widgets,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onMoreDetailsPressed,
              child: Text('More Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  final String label;
  final int count;
  final Color countColor;
  final VoidCallback onStatClicked;

  StatWidget({
    required this.label,
    required this.count,
    required this.countColor,
    required this.onStatClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onStatClicked,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: countColor.withOpacity(0.1),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: countColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
