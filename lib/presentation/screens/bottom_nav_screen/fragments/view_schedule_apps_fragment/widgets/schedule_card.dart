import 'dart:typed_data';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_schedule_apps_fragment/widgets/action_button.dart';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_schedule_apps_fragment/widgets/info_chip.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final Uint8List iconBytes;
  final String appName;
  final String? scheduleLabel;
  final String formattedTime;
  final String formattedDate;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ScheduleCard({
    required this.iconBytes,
    required this.appName,
    required this.scheduleLabel,
    required this.formattedTime,
    required this.formattedDate,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Icon with gradient ring
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFD32F2F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD32F2F).withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.memory(
                  iconBytes,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appName,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: 0.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (scheduleLabel != null && scheduleLabel!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        scheduleLabel!,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFFD32F2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InfoChip(
                        icon: Icons.access_time_rounded,
                        label: formattedTime,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: InfoChip(
                          icon: Icons.calendar_today_rounded,
                          label: formattedDate,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: Icons.edit_rounded,
                  color: const Color(0xFF1565C0),
                  backgroundColor: const Color(0xFFE8F0FE),
                  onTap: onEdit,
                ),
                const SizedBox(height: 6),
                ActionButton(
                  icon: Icons.delete_rounded,
                  color: const Color(0xFFD32F2F),
                  backgroundColor: const Color(0xFFFFF0F0),
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}