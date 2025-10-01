import 'package:get/get.dart';

class FavoritesController extends GetxController {
  // Observable list of upcoming followups
  final RxList<Map<String, dynamic>> followups = <Map<String, dynamic>>[
    {
      'task_id': '1',
      'name': 'Vikram Singh',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Repair',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': true,
      'email': 'vikram.singh@gmail.com',
      'purchaseDate': '10 Jan 2023',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Pune Cars',
      'fuelType': 'Diesel',
      'location': 'Pune',
    },
    {
      'task_id': '2',
      'name': 'Ananya Banerjee',
      'due_date': '2025-09-10T14:30:00Z',
      'mobile': '+9876543210',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover',
      'lead_id': 'lead_002',
      'favourite': false,
      'email': 'ananya.banerjee@gmail.com',
      'purchaseDate': '22 Feb 2022',
      'nextServiceDate': '12 Sep 2025',
      'dealership': 'Kolkata Motors',
      'fuelType': 'Petrol',
      'location': 'Kolkata',
    },
    {
      'task_id': '3',
      'name': 'Virat Kohli',
      'due_date': '2025-09-12T09:15:00Z',
      'mobile': '+5556667777',
      'subject': 'Scheduled Repair',
      'PMI': 'Defender',
      'lead_id': 'lead_003',
      'favourite': false,
      'email': 'virat.kohli@gmail.com',
      'purchaseDate': '12 May 2021',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Delhi Automobiles',
      'fuelType': 'Petrol',
      'location': 'Delhi',
    },
  ].obs;

  // Observable list of overdue followups
  final RxList<Map<String, dynamic>> overdueFollowups = <Map<String, dynamic>>[
    {
      'task_id': '4',
      'name': 'Rajesh Kumar',
      'due_date': '2025-09-05T10:00:00Z',
      'mobile': '+1122334455',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover Sport',
      'lead_id': 'lead_004',
      'favourite': false,
      'email': 'rajesh.kumar@gmail.com',
      'purchaseDate': '15 Mar 2022',
      'nextServiceDate': '05 Sep 2025',
      'dealership': 'Mumbai Motors',
      'fuelType': 'Diesel',
      'location': 'Mumbai',
    },
    {
      'task_id': '5',
      'name': 'Priya Sharma',
      'due_date': '2025-09-08T14:00:00Z',
      'mobile': '+2233445566',
      'subject': 'Scheduled Repair',
      'PMI': 'Discovery',
      'lead_id': 'lead_005',
      'favourite': true,
      'email': 'priya.sharma@gmail.com',
      'purchaseDate': '20 Jun 2021',
      'nextServiceDate': '08 Sep 2025',
      'dealership': 'Bangalore Cars',
      'fuelType': 'Petrol',
      'location': 'Bangalore',
    },
       {
      'task_id': '6',
      'name': 'Priya pandey',
      'due_date': '2025-09-08T14:00:00Z',
      'mobile': '+2233445566',
      'subject': 'Scheduled Repair',
      'PMI': 'Discovery',
      'lead_id': 'lead_005',
      'favourite': true,
      'email': 'priya.sharma@gmail.com',
      'purchaseDate': '20 Jun 2021',
      'nextServiceDate': '08 Sep 2025',
      'dealership': 'Bangalore Cars',
      'fuelType': 'Petrol',
      'location': 'Bangalore',
    },
  ].obs;

  // Observable list of upcoming service appointments
  final RxList<Map<String, dynamic>> serviceAppointments = <Map<String, dynamic>>[
    {
      'task_id': '1',
      'name': 'Aman Prajapati',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Repair',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': true,
      'email': 'aman.prajapati@gmail.com',
      'purchaseDate': '10 Jan 2023',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Pune Cars',
      'fuelType': 'Diesel',
      'location': 'Pune',
    },
    {
      'task_id': '2',
      'name': 'Anand Yadav',
      'due_date': '2025-09-10T14:30:00Z',
      'mobile': '+9876543210',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover',
      'lead_id': 'lead_002',
      'favourite': false,
      'email': 'anand.yadav@gmail.com',
      'purchaseDate': '22 Feb 2022',
      'nextServiceDate': '12 Sep 2025',
      'dealership': 'Kolkata Motors',
      'fuelType': 'Petrol',
      'location': 'Kolkata',
    },
    {
      'task_id': '3',
      'name': 'Aleem Khan',
      'due_date': '2025-09-12T09:15:00Z',
      'mobile': '+5556667777',
      'subject': 'Scheduled Repair',
      'PMI': 'Defender',
      'lead_id': 'lead_003',
      'favourite': false,
      'email': 'aleem.khan@gmail.com',
      'purchaseDate': '12 May 2021',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Delhi Automobiles',
      'fuelType': 'Petrol',
      'location': 'Delhi',
    },
  ].obs;

  // Observable list of overdue service appointments
  final RxList<Map<String, dynamic>> overdueServiceAppointments = <Map<String, dynamic>>[
    {
      'task_id': '1',
      'name': 'Vishal Mishra',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': false,
      'email': 'vishal.mishra@gmail.com',
      'purchaseDate': '10 Jan 2023',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Pune Cars',
      'fuelType': 'Diesel',
      'location': 'Pune',
    },
    {
      'task_id': '2',
      'name': 'Hemant Naidu',
      'due_date': '2025-09-10T14:30:00Z',
      'mobile': '+9876543210',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover',
      'lead_id': 'lead_002',
      'favourite': false,
      'email': 'hemant.naidu@gmail.com',
      'purchaseDate': '22 Feb 2022',
      'nextServiceDate': '12 Sep 2025',
      'dealership': 'Kolkata Motors',
      'fuelType': 'Petrol',
      'location': 'Kolkata',
    },
    {
      'task_id': '3',
      'name': 'Rakesh Sharma',
      'due_date': '2025-09-12T09:15:00Z',
      'mobile': '+5556667777',
      'subject': 'Scheduled Repair',
      'PMI': 'Defender',
      'lead_id': 'lead_003',
      'favourite': false,
      'email': 'rakesh.sharma@gmail.com',
      'purchaseDate': '12 May 2021',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Delhi Automobiles',
      'fuelType': 'Petrol',
      'location': 'Delhi',
    },
  ].obs;

  // Get only favorite followups
  List<Map<String, dynamic>> get favoriteFollowups {
    return followups.where((item) => item['favourite'] == true).toList();
  }

  // Get only favorite overdue followups
  List<Map<String, dynamic>> get favoriteOverdueFollowups {
    return overdueFollowups.where((item) => item['favourite'] == true).toList();
  }

  // Get only favorite service appointments
  List<Map<String, dynamic>> get favoriteServiceAppointments {
    return serviceAppointments.where((item) => item['favourite'] == true).toList();
  }

  // Get only favorite overdue service appointments
  List<Map<String, dynamic>> get favoriteOverdueServiceAppointments {
    return overdueServiceAppointments.where((item) => item['favourite'] == true).toList();
  }

  // Toggle favorite status for upcoming followups
  void toggleFavorite(String taskId) {
    final index = followups.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      followups[index]['favourite'] = !followups[index]['favourite'];
      followups.refresh();
    }
  }

  // Toggle favorite status for overdue followups
  void toggleOverdueFavorite(String taskId) {
    final index = overdueFollowups.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      overdueFollowups[index]['favourite'] = !overdueFollowups[index]['favourite'];
      overdueFollowups.refresh();
    }
  }

  // Toggle favorite status for service appointments
  void toggleServiceAppointmentFavorite(String taskId) {
    final index = serviceAppointments.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      serviceAppointments[index]['favourite'] = !serviceAppointments[index]['favourite'];
      serviceAppointments.refresh();
    }
  }

  // Toggle favorite status for overdue service appointments
  void toggleOverdueServiceAppointmentFavorite(String taskId) {
    final index = overdueServiceAppointments.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      overdueServiceAppointments[index]['favourite'] = !overdueServiceAppointments[index]['favourite'];
      overdueServiceAppointments.refresh();
    }
  }

  // Update upcoming followup data
  void updateFollowup(String taskId, Map<String, dynamic> updatedData) {
    final index = followups.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      followups[index] = updatedData;
      followups.refresh();
    }
  }

  // Update overdue followup data
  void updateOverdueFollowup(String taskId, Map<String, dynamic> updatedData) {
    final index = overdueFollowups.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      overdueFollowups[index] = updatedData;
      overdueFollowups.refresh();
    }
  }

  // Update service appointment data
  void updateServiceAppointment(String taskId, Map<String, dynamic> updatedData) {
    final index = serviceAppointments.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      serviceAppointments[index] = updatedData;
      serviceAppointments.refresh();
    }
  }

  // Update overdue service appointment data
  void updateOverdueServiceAppointment(String taskId, Map<String, dynamic> updatedData) {
    final index = overdueServiceAppointments.indexWhere((item) => item['task_id'] == taskId);
    if (index != -1) {
      overdueServiceAppointments[index] = updatedData;
      overdueServiceAppointments.refresh();
    }
  }
}