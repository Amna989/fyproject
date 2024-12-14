import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data (Replace with actual data from backend later)
    final userHistory = [
      {
        'date': '2024-11-07',
        'result': 'Positive - Viral Pneumonia',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'date': '2024-11-08',
        'result': 'Negative',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'date': '2024-11-09',
        'result': 'Positive - Bacterial Pneumonia',
        'imageUrl': 'https://via.placeholder.com/150',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF010713),
        elevation: 0,
        title: const Text(
          'User   History',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            color: Color(0xFFE3F2FD),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF010713),
              Color(0xFF0D2962),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: userHistory.length,
          itemBuilder: (context, index) {
            final historyItem = userHistory[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.7),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(9.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  tileColor: Colors.transparent,
                  title: Row(
                    children: [
                      // Circular Avatar

                      const SizedBox(width: 12),
                      // Result Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Result
                          Text(
                            historyItem['result']!,
                            style: const TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Date
                          Text(
                            'Date: ${historyItem['date']}',
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        // Placeholder for uploaded image
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200], // Placeholder color
                          ),
                          child: historyItem['imageUrl']!.isEmpty
                              ? Center(
                            child: Text(
                              'User uploaded image will appear here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              historyItem['imageUrl']!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Image Upload',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
