import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Api/http_client.dart';
import '../models/worker_models.dart';

class RequestDetailPage extends StatefulWidget {
  final WorkerRequest request;

  RequestDetailPage({required this.request});

  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  bool isLoading = false; // Добавляем индикатор загрузки

  Future<void> _takeJob() async {
    setState(() {
      isLoading = true;
    });
    try {


      print(widget.request.clientId);
      print(widget.request.employeeId);
      print(widget.request.statusesId);
      HttpService httpService = HttpService();
      await httpService.updateRequestStatus(widget.request.id!, 4, widget.request.clientId!, 'worker');

      Navigator.pop(context, true);

    } catch (e) {
      print("Ошибка при взятии в работу: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void requestManageExternalStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      bool isPermanentlyDenied = await Permission.manageExternalStorage.isPermanentlyDenied;
      if (isPermanentlyDenied) {
        openAppSettings(); // Открыть настройки приложения для пользователя
      } else {
        // Запросить разрешение
        await Permission.manageExternalStorage.request();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request.title ?? 'No title'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetailCard(
                icon: Icons.assignment,
                title: "Тип услуги",
                content: widget.request.title ?? 'No title',
              ),
              SizedBox(height: 10),
              _buildDetailCard(
                icon: Icons.description,
                title: "Описание",
                content: widget.request.description ?? 'Нет описания',
              ),
              SizedBox(height: 10),
              _buildDetailCard(
                icon: Icons.calendar_today,
                title: "Дата и время",
                content: widget.request.createdAt != null
                    ? DateFormat('yyyy-MM-dd – kk:mm').format(widget.request.createdAt!)
                    : 'No date',
              ),
              SizedBox(height: 20),
              if (widget.request.imagePaths != null && widget.request.imagePaths!.isNotEmpty)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Прикрепленные изображения",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(widget.request.imagePaths![0]),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _takeJob, // Отключаем кнопку во время загрузки
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Цвет кнопки
                  onPrimary: Colors.white, // Цвет текста
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Закругленные углы
                  ),
                  elevation: 5, // Тень кнопки
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Размеры кнопки
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text(
                  "Взять в работу",
                  style: TextStyle(
                    fontSize: 18, // Размер шрифта
                    fontWeight: FontWeight.bold, // Жирный шрифт
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String content}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: Colors.teal, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
