import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'team_controller.dart';

class TeamPreviewPage extends StatelessWidget {
  final TeamController controller;
  const TeamPreviewPage({super.key, required this.controller});

  void _rename(BuildContext context, int index) async {
    final item = controller.team1[index];
    final ctrl = TextEditingController(text: item.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('แก้ไขชื่อโปเกมอน'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'ชื่อใหม่'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ยกเลิก')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, ctrl.text.trim()), child: const Text('บันทึก')),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      controller.renameMember(index, newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.team1;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('ทีม 1', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) {
              if (i < items.length) {
                final m = items[i];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(m.img, width: 90, height: 90, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: Text(
                        m.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _rename(context, i),
                          tooltip: 'แก้ชื่อ',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_forever),
                          onPressed: () => controller.removeMember(i),
                          tooltip: 'ลบ',
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Container(
                  width: 100,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text('ว่าง'),
                );
              }
            }),
          ),
        ],
      );
    });
  }
}
