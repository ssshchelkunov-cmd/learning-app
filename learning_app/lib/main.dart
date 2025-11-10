import 'package:flutter/material.dart';

void main() {
  runApp(LearningApp());
}

class LearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Обучающие курсы',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CourseListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  final int lessonCount;
  final String icon;
  
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.lessonCount,
    required this.icon,
  });
}

class CourseListScreen extends StatefulWidget {
  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final List<Course> courses = [
    Course(
      id: '1',
      title: 'Основы программирования 🐍',
      description: 'Научись основам Python с нуля. Идеально для начинающих.',
      lessonCount: 12,
      icon: '💻',
    ),
    Course(
      id: '2',
      title: 'Flutter для начинающих 📱',
      description: 'Создай свое первое мобильное приложение',
      lessonCount: 8,
      icon: '📱',
    ),
    Course(
      id: '3',
      title: 'Веб-разработка 💻',
      description: 'Создавай современные веб-сайты на HTML/CSS/JS',
      lessonCount: 15,
      icon: '🌐',
    ),
    Course(
      id: '4',
      title: 'Базы данных 🗄️',
      description: 'Изучи SQL и основы работы с данными',
      lessonCount: 10,
      icon: '📊',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎓 Мои обучающие курсы'),
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(
            course: courses[index],
            onDelete: () {
              _deleteCourse(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCourseDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Курс удален'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showAddCourseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить новый курс'),
        content: Text('Эта функция в разработке! 🛠️\n\nСкоро можно будет добавлять свои курсы.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Понятно!'),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onDelete;

  const CourseCard({
    Key? key,
    required this.course,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    course.icon,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      course.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.library_books, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text(
                          '${course.lessonCount} уроков',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Spacer(),
                        Text(
                          'Бесплатно',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Удалить'),
                      ],
                    ),
                    onTap: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ссылка на курс скопирована!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок и иконка
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      course.icon,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Заголовок
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              
              // Описание
              Text(
                course.description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              
              // Статистика
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoItem(Icons.library_books, '${course.lessonCount} уроков'),
                    _buildInfoItem(Icons.timer, '~${course.lessonCount * 30} мин'),
                    _buildInfoItem(Icons.star, 'Для начинающих'),
                  ],
                ),
              ),
              SizedBox(height: 30),
              
              // Кнопка начала
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showStartCourseDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Начать обучение 🚀',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Программа курса
              Text(
                '📚 Программа курса:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              
              ...List.generate(
                course.lessonCount,
                (index) => LessonItem(
                  lessonNumber: index + 1,
                  title: _getLessonTitle(course.title, index + 1),
                  duration: '30 мин',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        SizedBox(height: 4),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _getLessonTitle(String courseTitle, int lessonNumber) {
    if (courseTitle.contains('Python') || courseTitle.contains('программирования')) {
      List<String> lessons = [
        'Введение в программирование',
        'Переменные и типы данных',
        'Условные операторы',
        'Циклы и итерации',
        'Функции и методы',
        'Списки и словари',
        'Работа с файлами',
        'Обработка ошибок',
        'Объектно-ориентированное программирование',
        'Библиотеки и модули',
        'Создание простых проектов',
        'Итоговый проект и тестирование'
      ];
      return lessons[lessonNumber - 1];
    } else if (courseTitle.contains('Flutter')) {
      List<String> lessons = [
        'Введение во Flutter и Dart',
        'Создание первого приложения',
        'Widgets и композиция',
        'State Management основы',
        'Навигация между экранами',
        'Работа с API и HTTP',
        'Локальные базы данных',
        'Публикация приложения'
      ];
      return lessons[lessonNumber - 1];
    } else {
      return 'Урок $lessonNumber: Основы темы';
    }
  }

  void _showStartCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Начать обучение? 🎯'),
        content: Text('Вы хотите начать курс "${course.title}"?\n\nЭто бесплатно и можно начать прямо сейчас!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Позже'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Курс "${course.title}" начат! 🎉 Удачи в обучении!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: Text('Начать обучение!'),
          ),
        ],
      ),
    );
  }
}

class LessonItem extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final String duration;

  const LessonItem({
    Key? key,
    required this.lessonNumber,
    required this.title,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            '$lessonNumber',
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(duration),
        trailing: Icon(Icons.play_circle_filled, color: Colors.blue),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Запуск урока: $title'),
              action: SnackBarAction(
                label: 'Отлично!',
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}