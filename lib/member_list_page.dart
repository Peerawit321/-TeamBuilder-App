import 'package:flutter/material.dart';
import 'team_controller.dart';
import 'member.dart';
import 'members.dart';

class MemberPickerSheet extends StatefulWidget {
  final TeamController controller;
  const MemberPickerSheet({super.key, required this.controller});

  @override
  State<MemberPickerSheet> createState() => _MemberPickerSheetState();
}

class _MemberPickerSheetState extends State<MemberPickerSheet> {
  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.filled(allMembers.length, false);
  }

  void _toggle(int i) {
    final chosen = _selected.where((e) => e).length;
    if (!_selected[i] && chosen >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เลือกได้สูงสุด 3 ตัว')),
      );
      return;
    }
    setState(() => _selected[i] = !_selected[i]);
  }

  void _confirm() {
    final picks = <Member>[];
    for (int i = 0; i < allMembers.length; i++) {
      if (_selected[i]) picks.add(allMembers[i]);
    }
    for (final m in picks) {
      if (widget.controller.team1.length < 3) {
        widget.controller.addMember(m);
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text('เลือกโปเกมอน (สูงสุด 3)',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: allMembers.length,
              itemBuilder: (context, i) {
                final m = allMembers[i];
                final sel = _selected[i];
                return GestureDetector(
                  onTap: () => _toggle(i),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: sel ? Colors.blue.withOpacity(.15) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: sel ? Colors.blue : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(m.img, width: 64, height: 64, fit: BoxFit.contain),
                        const SizedBox(height: 6),
                        Text(
                          m.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ยกเลิก'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _confirm,
                    icon: const Icon(Icons.check),
                    label: const Text('ยืนยัน'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
