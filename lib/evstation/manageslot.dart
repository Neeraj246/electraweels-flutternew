import 'package:flutter/material.dart';

class ManageSlotPage extends StatefulWidget {
  const ManageSlotPage({Key? key}) : super(key: key);

  @override
  State<ManageSlotPage> createState() => _ManageSlotPageState();
}

class _ManageSlotPageState extends State<ManageSlotPage> {
  // Sample data for slots
  final List<Map<String, dynamic>> _slots = List.generate(10, (index) {
    return {
      "slot": "Slot ${index + 1}",
      "status": index % 2 == 0 ? "Available" : "Booked",
    };
  });

  // Search-related variables
  String _searchQuery = "";

  // Filtered slots based on search query
  List<Map<String, dynamic>> get _filteredSlots {
    if (_searchQuery.isEmpty) {
      return _slots;
    }
    return _slots
        .where((slot) => slot['slot']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Slots",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF2A5D34), // Dark green color
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          // Background color
          Container(
            color: Colors.white, // White background
          ),
          Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF2A5D34)),
                    hintText: "Search for a slot...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF2A5D34)),
                    ),
                  ),
                ),
              ),
              // Slots list
              Expanded(
                child: _filteredSlots.isEmpty
                    ? const Center(
                        child: Text(
                          "No slots found.",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredSlots.length,
                        itemBuilder: (context, index) {
                          final slot = _filteredSlots[index];
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
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                                gradient: slot['status'] == "Available"
                                    ? const LinearGradient(
                                        colors: [Color(0xFF2A5D34), Color(0xFF5CA464)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : const LinearGradient(
                                        colors: [Color(0xFF8C8C8C), Color(0xFFC4C4C4)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  slot['status'] == "Available"
                                      ? Icons.check_circle_outline
                                      : Icons.cancel_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                title: Text(
                                  slot['slot'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  "Status: ${slot['status']}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: slot['status'] == "Available"
                                    ? ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _slots[_slots.indexOf(slot)]['status'] =
                                                "Booked";
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${slot['slot']} successfully booked!",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          backgroundColor: Colors.white,
                                          foregroundColor: const Color(0xFF2A5D34),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text("Book"),
                                      )
                                    : ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          backgroundColor:
                                              Colors.white.withOpacity(0.3),
                                          foregroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text("Booked"),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
