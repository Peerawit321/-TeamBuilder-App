import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'team_controller.dart';
import 'member_list_page.dart';
import 'team_preview_page.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});
  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final TeamController c = Get.find<TeamController>();
  final TextEditingController _teamNameCtrl = TextEditingController();

  void _openPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: MemberPickerSheet(controller: c),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _teamNameCtrl.text = c.teamName.value;
    ever<String>(c.teamName, (name) {
      if (_teamNameCtrl.text != name) _teamNameCtrl.text = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Builder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _teamNameCtrl,
                decoration: InputDecoration(
                  labelText: 'ตั้งชื่อทีม',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: 'บันทึกชื่อทีม',
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      c.teamName.value = _teamNameCtrl.text.trim();
                      await c.saveNow();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('บันทึกชื่อทีมแล้ว')),
                        );
                      }
                    },
                  ),
                ),
                onChanged: (v) => c.teamName.value = v,
              ),
              const SizedBox(height: 16),
              TeamPreviewPage(controller: c),
            ],
          ),
        ),
      ),

      // ปุ่มลอยมุมขวาล่าง
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openPicker,
        icon: const Icon(Icons.catching_pokemon),
        label: const Text('เลือกโปเกมอน'),
      ),
    );
  }
}
