import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'member.dart';

class TeamController extends GetxController {
  final RxString teamName = ''.obs;
  final RxList<Member> team1 = <Member>[].obs;

  static const _kTeamName = 'teamName';
  static const _kTeam1 = 'team1'; // json string

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
    // auto-save เมื่อมีการเปลี่ยนแปลง
    ever<String>(teamName, (_) => _saveToStorage());
    ever<List<Member>>(team1, (_) => _saveToStorage());
  }

  void addMember(Member m) {
    if (team1.length >= 3) return;
    team1.add(m);
  }

  void removeMember(int index) {
    if (index >= 0 && index < team1.length) team1.removeAt(index);
  }

  void renameMember(int index, String newName) {
    if (index < 0 || index >= team1.length) return;
    final current = team1[index];
    team1[index] = Member(name: newName, img: current.img);
  }

  /// ให้หน้าจอกดบันทึกเองได้ (Manual Save)
  Future<void> saveNow() async => _saveToStorage();

  Future<void> _saveToStorage() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kTeamName, teamName.value);
    await sp.setString(_kTeam1, Member.encodeList(team1.toList()));
  }

  Future<void> _loadFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    teamName.value = sp.getString(_kTeamName) ?? '';
    final raw = sp.getString(_kTeam1) ?? '[]';
    team1.assignAll(Member.decodeList(raw));
  }
}
