import 'package:flutter/material.dart';

class ReviewsAndComplaintsPage extends StatefulWidget {
  const ReviewsAndComplaintsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsAndComplaintsPage> createState() =>
      _ReviewsAndComplaintsPageState();
}

class _ReviewsAndComplaintsPageState extends State<ReviewsAndComplaintsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for reviews and complaints
  final List<Map<String, String>> reviews = [
    {
      "user": "John Doe",
      "timestamp": "2024-11-19 10:00 AM",
      "content": "The station is clean and well-maintained. Great service!"
    },
    {
      "user": "Alice Smith",
      "timestamp": "2024-11-18 08:45 PM",
      "content": "Charging speed could be improved."
    },
  ];

  final List<Map<String, String>> complaints = [
    {
      "user": "Mark Johnson",
      "timestamp": "2024-11-17 05:30 PM",
      "content": "The station was out of service when I arrived."
    },
    {
      "user": "Emma Brown",
      "timestamp": "2024-11-16 01:15 PM",
      "content": "The payment system wasn't working properly."
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text(
          "Reviews & Complaints",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor:Color.fromARGB(255, 232, 235, 239), // Softer blue
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.star_rate), text: "Reviews"),
            Tab(icon: Icon(Icons.report_problem), text: "Complaints"),
          ],
          indicatorColor: Colors.amberAccent,
          indicatorWeight: 3,
        ),
      ),
      body: Stack(
        children: [
          // Background gradient with purple and blue
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 1, 59, 12), Color(0xFF4C92B1)], // Cool tones
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          TabBarView(
            controller: _tabController,
            children: [
              // Reviews Tab
              buildList(reviews, "No reviews available."),
              // Complaints Tab
              buildList(complaints, "No complaints available."),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildList(List<Map<String, String>> items, String emptyMessage) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              hintText: "Search...",
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        // List of Reviews/Complaints
        Expanded(
          child: items.isEmpty
              ? Center(
                  child: Text(
                    emptyMessage,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                          color: const Color(0xFF2F4F6C), // Soft greyish blue
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              item['user']![0],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C92B1), // Soft blue
                              ),
                            ),
                          ),
                          title: Text(
                            item['user']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                item['timestamp']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item['content']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
