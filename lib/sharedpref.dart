import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const SHARED_PREF_NAME = "mypreferences";
  static const KEY_STAFF_ID = "staff_id";
  static const KEY_ROLE_ID = "role_id";
  static const KEY_STAFF_NAME = "user";
  static const KEY_ROOM_NAME = "Rooms";
  static const KEY_DEPT_NAME = "Department";
  static const KEY_MEET_NAME = "Meeting_time";

  static SharedPreferences? _preferences;

  SharedPref._();

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<SharedPref> getInstance() async {
    if (_preferences == null) {
      await initialize();
    }
    return SharedPref._();
  }

  Future<void> storeStaffId(String staffId) async {
    await _preferences?.setString(KEY_STAFF_ID, staffId);
  }
  Future<void> storeRoleId(String RoleId) async {
    await _preferences?.setString(KEY_ROLE_ID, RoleId);
  }
  Future<void> storeStaffName(String StaffName) async {
    await _preferences?.setString(KEY_STAFF_NAME,StaffName);
  }
  Future<void> storeRoomName(String RoomName) async {
    await _preferences?.setString(KEY_ROOM_NAME,RoomName);
  }
  Future<void> storeDeptName(String DeptName) async {
    await _preferences?.setString(KEY_DEPT_NAME, DeptName);
  }


  String? getStaffId() {
    return _preferences?.getString(KEY_STAFF_ID);
  }
  String? getRoleId() {
    return _preferences?.getString(KEY_ROLE_ID);
  }
  String? getStaffName() {
    return _preferences?.getString(KEY_STAFF_NAME);
  }
  String? getRoomName() {
    return _preferences?.getString(KEY_ROOM_NAME);
  }
  String? getDeptName() {
    return _preferences?.getString(KEY_DEPT_NAME);
  }
}