import 'package:geo_school/database/image_model.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // only have a single app-wide reference to the database
  // static late Database database;

  // this opens the database (and creates it if it doesn't exist)
  static Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'geoschool.db'),
      version: 1,
      onCreate: onDatabaseCreate,
    );
  }
  

  // SQL code to create the database table
  static Future onDatabaseCreate(Database db, int version) async {
    await db.execute(
        "create table Schools (id text primary key,user_id text,school_id text,level text,status text,zone text,cycle text,building_material text,altitude text,accuracy text,address text,lat text,lng text,electricity text,water text,internet text,toilet text,connection_speed text,mobile_network text,fencing text,total_students text,girls text,boys text,teaching_staff text,library text,computer_room text,phone_no text,description text,image text,approved text,modified text,reason text,approved_by text,created_at text,approved_at text,updated_at text,name text, region_id text,township_id text,department_id text,region_name text,township_name text,department_name text,recordUploaded text)");

    await db.execute(
        "CREATE TABLE Images(image_id INTEGER PRIMARY KEY autoincrement,school_id TEXT,image_path TEXT)");
  }

  Future<List<SchoolListModel>> getAllSchools() async {
    Database dbClient = await initDatabase();
    List<SchoolListModel> schools = [];
    List<Map<String, dynamic>> maps =
        await dbClient.rawQuery('Select * From Schools');
    if (maps.length > 0) {
      print(maps.length);
      for (var m in maps) {
        schools.add(SchoolListModel.fromJson(m));
      }
      return schools;
    }
    return schools;
  }

  Future<SchoolListModel> getSchool(String id) async {
    Database dbClient = await initDatabase();
    SchoolListModel school = SchoolListModel();
    List<Map<String, dynamic>> maps =
        await dbClient.query('Schools', where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      school = SchoolListModel.fromJson(maps.first);
    }
    return school;
  }

  Future<int> insertSchool(Map<String, dynamic> school) async {
    Database dbClient = await initDatabase();
    school.remove('images');
    return await dbClient.insert('Schools', school);
  }

  Future<int> updateSchool(SchoolListModel school) async {
    Database dbClient = await initDatabase();
    Map<String, dynamic> data = school.toJson();
    data.remove('images');
    return await dbClient
        .update('Schools', data, where: 'id = ?', whereArgs: [school.id]);
  }

  Future<List<DbImageModel>> getImages(String schoolId) async {
    Database dbClient = await initDatabase();
    List<DbImageModel> images = [];
    List<Map> maps = await dbClient
        .query('Images', where: 'school_id = ?', whereArgs: [schoolId]);
    if (maps.length > 0) {
      for (var img in maps) {
        images.add(DbImageModel.fromJson(img));
      }
      return images;
    }
    return images;
  }

  Future<int> insertImage(Map<String, dynamic> image) async {
    Database dbClient = await initDatabase();
    return await dbClient.insert('Images', image);
  }

  Future<int> removeImage(int imageId) async {
    Database dbClient = await initDatabase();
    return await dbClient
        .delete('Images', where: 'image_id = ?', whereArgs: [imageId]);
  }

  Future<int> updateImage(DbImageModel image) async {
    Database dbClient = await initDatabase();
    return await dbClient.update('Images', image.toJson(),
        where: 'school_id = ?', whereArgs: [image.schoolId]);
  }

  Future close() async {
    Database dbClient = await initDatabase();
    dbClient.close();
  }
}
