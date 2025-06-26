import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const CafeManagementApp());
}

class CafeManagementApp extends StatelessWidget {
  const CafeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewMaster Pro',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const MainDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;
  String _selectedModule = 'Dashboard';

  // Sample data for demonstration
  final List<Map<String, dynamic>> _quickStats = [
    {
      'title': 'Today Sales',
      'value': '\$1,245',
      'icon': Icons.point_of_sale,
      'color': Colors.green
    },
    {
      'title': 'Pending Orders',
      'value': '8',
      'icon': Icons.receipt,
      'color': Colors.orange
    },
    {
      'title': 'New Customers',
      'value': '5',
      'icon': Icons.person_add,
      'color': Colors.blue
    },
    {
      'title': 'Coffee Stock',
      'value': '85%',
      'icon': Icons.inventory,
      'color': Colors.brown
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedModule),
        leading: IconButton(
          icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
          onPressed: () {
            setState(() {
              _isDrawerOpen = !_isDrawerOpen;
            });
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundImage:
                NetworkImage('https://randomuser.me/api/portraits/men/41.jpg'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Navigation Drawer
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isDrawerOpen ? 250 : 70,
            child: NavigationDrawer(
              selectedModule: _selectedModule,
              onModuleSelected: (module) {
                setState(() {
                  _selectedModule = module;
                  _isDrawerOpen = false;
                });
              },
              isExpanded: _isDrawerOpen,
            ),
          ),
          // Main Content
          Expanded(
            child: _buildModuleContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleContent() {
    switch (_selectedModule) {
      case 'Dashboard':
        return _buildDashboard();
      case 'Coffee Trading':
        return const CoffeeTradingPortal();
      case 'Sales Reports':
        return const SalesReports();
      case 'Inventory':
        return const SalesReports();
      case 'Staff':
        return const SalesReports();
      case 'Customers':
        return const SalesReports();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats
          const Text('Quick Stats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: _quickStats.length,
            itemBuilder: (context, index) {
              return _buildStatCard(_quickStats[index]);
            },
          ),

          // Recent Orders
          const SizedBox(height: 24),
          const Text('Recent Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRecentOrdersTable(),

          // Coffee Stock Alert
          const SizedBox(height: 24),
          const Text('Stock Alerts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildStockAlerts(),
        ],
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(stat['icon'], color: stat['color'], size: 28),
            const SizedBox(height: 8),
            Text(stat['title'], style: TextStyle(color: Colors.grey[600])),
            Text(stat['value'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersTable() {
    // Sample data
    final orders = [
      {
        'id': '#1001',
        'customer': 'John Doe',
        'amount': '\$24.50',
        'status': 'Completed'
      },
      {
        'id': '#1002',
        'customer': 'Jane Smith',
        'amount': '\$18.75',
        'status': 'Preparing'
      },
      {
        'id': '#1003',
        'customer': 'Robert Johnson',
        'amount': '\$32.20',
        'status': 'Pending'
      },
      {
        'id': '#1004',
        'customer': 'Emily Davis',
        'amount': '\$15.90',
        'status': 'Completed'
      },
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Order ID')),
            DataColumn(label: Text('Customer')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Status')),
          ],
          rows: orders.map((order) {
            return DataRow(cells: [
              DataCell(Text(order['id'].toString())),
              DataCell(Text(order['customer'].toString())),
              DataCell(Text(order['amount'].toString())),
              DataCell(
                Chip(
                  label: Text(order['status'].toString()),
                  backgroundColor: order['status'] == 'Completed'
                      ? Colors.green[100]
                      : order['status'] == 'Preparing'
                          ? Colors.orange[100]
                          : Colors.red[100],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStockAlerts() {
    // Sample data
    final alerts = [
      {'item': 'Ethiopian Yirgacheffe', 'current': '5 lbs', 'min': '10 lbs'},
      {'item': 'Colombian Supremo', 'current': '8 lbs', 'min': '15 lbs'},
      {'item': 'Oat Milk', 'current': '3 units', 'min': '10 units'},
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: alerts.map((alert) {
            return ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: Text(alert['item'].toString()),
              subtitle:
                  Text('Current: ${alert['current']} (Min: ${alert['min']})'),
              trailing: ElevatedButton(
                child: const Text('Reorder'),
                onPressed: () {},
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final String selectedModule;
  final Function(String) onModuleSelected;
  final bool isExpanded;

  const NavigationDrawer({
    super.key,
    required this.selectedModule,
    required this.onModuleSelected,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.brown[50],
        child: Column(
          children: [
            // Header
            Container(
              height: 150,
              color: Colors.brown[700],
              padding: const EdgeInsets.all(16),
              child: Center(
                child: isExpanded
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/41.jpg'),
                          ),
                          SizedBox(height: 10),
                          Text('BrewMaster Pro',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text('Admin',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      )
                    : const Icon(Icons.coffee, color: Colors.white, size: 30),
              ),
            ),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildNavItem(Icons.dashboard, 'Dashboard', isExpanded),
                  _buildExpandableNavItem(
                    Icons.shopping_basket,
                    'Coffee Trading',
                    isExpanded,
                    [
                      'Green Coffee',
                      'Roasted Coffee',
                      'Suppliers',
                      'Transactions'
                    ],
                  ),
                  _buildExpandableNavItem(
                    Icons.analytics,
                    'Reports',
                    isExpanded,
                    [
                      'Sales Reports',
                      'Inventory Reports',
                      'Customer Reports',
                      'Profit/Loss'
                    ],
                  ),
                  _buildNavItem(Icons.inventory, 'Inventory', isExpanded),
                  _buildNavItem(Icons.people, 'Staff', isExpanded),
                  _buildNavItem(Icons.group, 'Customers', isExpanded),
                  _buildNavItem(Icons.settings, 'Settings', isExpanded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, bool isExpanded) {
    final isSelected = selectedModule == title;
    return ListTile(
      leading:
          Icon(icon, color: isSelected ? Colors.brown[800] : Colors.brown[600]),
      title: isExpanded
          ? Text(title,
              style: TextStyle(
                  color: isSelected ? Colors.brown[800] : Colors.brown[600]))
          : null,
      selected: isSelected,
      onTap: () => onModuleSelected(title),
      tileColor: isSelected ? Colors.brown[100] : null,
    );
  }

  Widget _buildExpandableNavItem(
      IconData icon, String title, bool isExpanded, List<String> subItems) {
    final isSelected = subItems.contains(selectedModule);
    return ExpansionTile(
      leading:
          Icon(icon, color: isSelected ? Colors.brown[800] : Colors.brown[600]),
      title: isExpanded ? Text(title) : const SizedBox(),
      initiallyExpanded: isSelected,
      childrenPadding: const EdgeInsets.only(left: 30),
      children: subItems.map((item) {
        return ListTile(
          title: Text(item),
          selected: selectedModule == item,
          onTap: () => onModuleSelected(item),
          tileColor: selectedModule == item ? Colors.brown[100] : null,
        );
      }).toList(),
    );
  }
}

class CoffeeTradingPortal extends StatelessWidget {
  const CoffeeTradingPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Coffee Trading Portal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Trading Dashboard
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current Market Prices',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.refresh),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMarketPricesTable(),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('New Trade'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Recent Trades
          const SizedBox(height: 24),
          const Text('Recent Trades',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRecentTradesTable(),
        ],
      ),
    );
  }

  Widget _buildMarketPricesTable() {
    final prices = [
      {
        'origin': 'Ethiopia',
        'type': 'Yirgacheffe',
        'price': '\$8.50/lb',
        'change': '+2.5%'
      },
      {
        'origin': 'Colombia',
        'type': 'Supremo',
        'price': '\$6.75/lb',
        'change': '-1.2%'
      },
      {
        'origin': 'Brazil',
        'type': 'Santos',
        'price': '\$5.20/lb',
        'change': '+0.8%'
      },
      {
        'origin': 'Kenya',
        'type': 'AA',
        'price': '\$7.90/lb',
        'change': '+3.1%'
      },
    ];

    return DataTable(
      columns: const [
        DataColumn(label: Text('Origin')),
        DataColumn(label: Text('Type')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Change')),
      ],
      rows: prices.map((price) {
        return DataRow(cells: [
          DataCell(Text(price['origin'].toString())),
          DataCell(Text(price['type'].toString())),
          DataCell(Text(price['price'].toString())),
          DataCell(
            Text(
              price['change'].toString(),
              // style: TextStyle(
              //   color:
              //       price['change'].startsWith('+') ? Colors.green : Colors.red,
              // ),
            ),
          ),
        ]);
      }).toList(),
    );
  }

  Widget _buildRecentTradesTable() {
    final trades = [
      {
        'date': '2023-05-15',
        'type': 'Purchase',
        'origin': 'Ethiopia',
        'quantity': '50 lbs',
        'price': '\$425.00'
      },
      {
        'date': '2023-05-10',
        'type': 'Purchase',
        'origin': 'Colombia',
        'quantity': '75 lbs',
        'price': '\$506.25'
      },
      {
        'date': '2023-05-05',
        'type': 'Sale',
        'origin': 'Brazil',
        'quantity': '30 lbs',
        'price': '\$156.00'
      },
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Origin')),
            DataColumn(label: Text('Quantity')),
            DataColumn(label: Text('Price')),
          ],
          rows: trades.map((trade) {
            return DataRow(cells: [
              DataCell(Text(trade['date'].toString())),
              DataCell(
                Chip(
                  label: Text(trade['type'].toString()),
                  backgroundColor: trade['type'] == 'Purchase'
                      ? Colors.blue[100]
                      : Colors.green[100],
                ),
              ),
              DataCell(Text(trade['origin'].toString())),
              DataCell(Text(trade['quantity'].toString())),
              DataCell(Text(trade['price'].toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class SalesReports extends StatelessWidget {
  const SalesReports({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sales Reports',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Report Filters
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Filter Reports',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: 'daily',
                          items: const [
                            DropdownMenuItem(
                                value: 'daily', child: Text('Daily')),
                            DropdownMenuItem(
                                value: 'weekly', child: Text('Weekly')),
                            DropdownMenuItem(
                                value: 'monthly', child: Text('Monthly')),
                            DropdownMenuItem(
                                value: 'custom',
                                child: Text('Custom Date Range')),
                          ],
                          onChanged: (value) {},
                          decoration:
                              const InputDecoration(labelText: 'Report Type'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Generate Report'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Sales Chart
          const SizedBox(height: 24),
          const Text('Sales Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSalesChart(),

          // Top Selling Items
          const SizedBox(height: 24),
          const Text('Top Selling Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTopSellingItems(),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    // This would be replaced with a real chart library like charts_flutter
    return Card(
      elevation: 2,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Sales Chart Visualization\n(Would show with a chart library)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSellingItems() {
    final items = [
      {'name': 'Espresso', 'sales': 128, 'revenue': '\$640.00'},
      {'name': 'Cappuccino', 'sales': 95, 'revenue': '\$570.00'},
      {'name': 'Latte', 'sales': 87, 'revenue': '\$478.50'},
      {'name': 'Cold Brew', 'sales': 65, 'revenue': '\$325.00'},
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Item')),
            DataColumn(label: Text('Sales Count')),
            DataColumn(label: Text('Revenue')),
          ],
          rows: items.map((item) {
            return DataRow(cells: [
              DataCell(Text(item['name'].toString())),
              DataCell(Text(item['sales'].toString())),
              DataCell(Text(item['revenue'].toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
