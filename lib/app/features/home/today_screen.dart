import 'package:flutter/material.dart';
import 'dart:async';

/// ===== Models =====

class Medication {
  final String id;
  final String name;
  final String dose;
  final String frequency;
  final List<String> times;

  Medication({
    required this.id,
    required this.name,
    required this.dose,
    required this.frequency,
    required this.times,
  });
}

class Appointment {
  final String id;
  final String title;
  final String provider;
  final String location;
  final String time;
  final String date;

  Appointment({
    required this.id,
    required this.title,
    required this.provider,
    required this.location,
    required this.time,
    required this.date,
  });
}

/// ===== State + Actions Contracts =====

class TodayActions {
  final void Function(String medId) takeMedication;
  final void Function(String medId) skipMedication;
  final void Function(String medId) undoLastAction;

  TodayActions({
    required this.takeMedication,
    required this.skipMedication,
    required this.undoLastAction,
  });
}

class TodayState {
  final List<Medication> medications;
  final List<Appointment> appointments;
  final bool leftHandMode;
  final List<String> favorites;

  TodayState({
    required this.medications,
    required this.appointments,
    required this.leftHandMode,
    required this.favorites,
  });
}

/// ===== Screen =====

class TodayScreen extends StatefulWidget {
  final TodayState state;
  final TodayActions actions;

  const TodayScreen({
    super.key,
    required this.state,
    required this.actions,
  });

  /// Temporary demo constructor so AppShell can render the UI without wiring real app state yet.
  factory TodayScreen.demo({Key? key}) {
    final demoState = TodayState(
      leftHandMode: false,
      favorites: const ['medications', 'calendar', 'communications'],
      medications: [
        Medication(
          id: 'm1',
          name: 'Amoxicillin',
          dose: '500mg',
          frequency: '2x/day',
          times: const ['08:00', '20:00'],
        ),
        Medication(
          id: 'm2',
          name: 'Vitamin D3',
          dose: '2000 IU',
          frequency: 'Daily',
          times: const ['09:00'],
        ),
      ],
      appointments: [
        Appointment(
          id: 'a1',
          title: 'Primary Care Visit',
          provider: 'Dr. Chen',
          location: 'Clinic A',
          time: '2:30 PM',
          date: _yyyyMmDd(DateTime.now()),
        ),
      ],
    );

    final demoActions = TodayActions(
      takeMedication: (_) {},
      skipMedication: (_) {},
      undoLastAction: (_) {},
    );

    return TodayScreen(
      key: key,
      state: demoState,
      actions: demoActions,
    );
  }

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  Timer? _clearTimer;

  ({String medId, String action})? lastAction; // action: "taken" | "skipped"

  @override
  void dispose() {
    _clearTimer?.cancel();
    super.dispose();
  }

  void _setLastAction(String medId, String action) {
    setState(() => lastAction = (medId: medId, action: action));
    _clearTimer?.cancel();
    _clearTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => lastAction = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayStr = _yyyyMmDd(now);

    final dueMedications = _computeDueMedications(
      meds: widget.state.medications,
      current: now,
    );

    final todayAppointments =
        widget.state.appointments.where((a) => a.date == todayStr).toList();

    final activeFavorites = _favoriteShortcuts
        .where((f) => widget.state.favorites.contains(f.routeKey))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(
              dateText: _formatTodayDate(now),
              onQuickActionTap: (routeKey) {
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (activeFavorites.isNotEmpty) ...[
                  _FavoritesCard(
                    favorites: activeFavorites,
                    onTap: (routeKey) {
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                if (dueMedications.isNotEmpty) ...[
                  _DueMedsCard(
                    meds: dueMedications,
                    leftHandMode: widget.state.leftHandMode,
                    lastAction: lastAction,
                    onTaken: (medId) {
                      widget.actions.takeMedication(medId);
                      _setLastAction(medId, 'taken');
                    },
                    onSkip: (medId) {
                      widget.actions.skipMedication(medId);
                      _setLastAction(medId, 'skipped');
                    },
                    onUndo: (medId) {
                      widget.actions.undoLastAction(medId);
                      setState(() => lastAction = null);
                    },
                    onViewAll: () {
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                if (todayAppointments.isNotEmpty) ...[
                  _AppointmentsCard(
                    appointments: todayAppointments,
                    onViewAll: () {
                    },
                    onTapItem: () {
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                if (dueMedications.isEmpty && todayAppointments.isEmpty)
                  const _EmptyStateCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== Header =====

class _Header extends StatelessWidget {
  final String dateText;
  final void Function(String routeKey) onQuickActionTap;

  const _Header({
    required this.dateText,
    required this.onQuickActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2563EB), // blue-600
              Color(0xFF1D4ED8), // blue-700
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dateText,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBFDBFE),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _QuickActionTile(
                    color: const Color(0xFF2563EB),
                    icon: Icons.medication_outlined,
                    label: 'Add Medication',
                    onTap: () => onQuickActionTap('addMedication'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionTile(
                    color: const Color(0xFF16A34A),
                    icon: Icons.calendar_month_outlined,
                    label: 'Schedule',
                    onTap: () => onQuickActionTap('calendar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionTile(
                    color: const Color(0xFF9333EA),
                    icon: Icons.chat_bubble_outline,
                    label: 'Quick Message',
                    onTap: () => onQuickActionTap('communications'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        height: 80,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Color(0x33000000),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== Favorites =====

class _FavoriteShortcut {
  final String routeKey;
  final String label;
  final IconData icon;

  const _FavoriteShortcut({
    required this.routeKey,
    required this.label,
    required this.icon,
  });
}

const _favoriteShortcuts = <_FavoriteShortcut>[
  _FavoriteShortcut(
    routeKey: 'medications',
    label: 'All Medications',
    icon: Icons.medication_outlined,
  ),
  _FavoriteShortcut(
    routeKey: 'calendar',
    label: 'Calendar',
    icon: Icons.calendar_month_outlined,
  ),
  _FavoriteShortcut(
    routeKey: 'communications',
    label: 'Messages',
    icon: Icons.chat_bubble_outline,
  ),
];

class _FavoritesCard extends StatelessWidget {
  final List<_FavoriteShortcut> favorites;
  final void Function(String routeKey) onTap;

  const _FavoritesCard({
    required this.favorites,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Color(0xFFF59E0B)),
              SizedBox(width: 8),
              Text(
                'Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...favorites.map((f) {
            return InkWell(
              onTap: () => onTap(f.routeKey),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Icon(f.icon, color: const Color(0xFF4B5563)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        f.label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// ===== Due Medications =====

class _DueMedsCard extends StatelessWidget {
  final List<Medication> meds;
  final bool leftHandMode;
  final ({String medId, String action})? lastAction;

  final void Function(String medId) onTaken;
  final void Function(String medId) onSkip;
  final void Function(String medId) onUndo;
  final VoidCallback onViewAll;

  const _DueMedsCard({
    required this.meds,
    required this.leftHandMode,
    required this.lastAction,
    required this.onTaken,
    required this.onSkip,
    required this.onUndo,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Medications Due',
      leadingIcon: Icons.medication_outlined,
      leadingColor: const Color(0xFF2563EB),
      onViewAll: onViewAll,
      children: meds.map((med) {
        final nextDoseTime = med.times.isNotEmpty ? med.times.first : '--:--';
        final showUndo = lastAction != null && lastAction!.medId == med.id;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              med.name,
              style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 4),
            Text(
              '${med.dose} • ${med.frequency}',
              style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Color(0xFF9CA3AF)),
                const SizedBox(width: 6),
                Text(
                  'Next: $nextDoseTime',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (showUndo)
              _UndoRow(
                action: lastAction!.action,
                leftHandMode: leftHandMode,
                onUndo: () => onUndo(med.id),
              )
            else
              _ActionButtonsRow(
                leftHandMode: leftHandMode,
                onTaken: () => onTaken(med.id),
                onSkip: () => onSkip(med.id),
              ),
          ],
        );
      }).toList(),
    );
  }
}

class _UndoRow extends StatelessWidget {
  final String action; // "taken" | "skipped"
  final bool leftHandMode;
  final VoidCallback onUndo;

  const _UndoRow({
    required this.action,
    required this.leftHandMode,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    final isTaken = action == 'taken';
    final bg = isTaken ? const Color(0xFFDCFCE7) : const Color(0xFFF3F4F6);
    final fg = isTaken ? const Color(0xFF15803D) : const Color(0xFF374151);
    final icon = isTaken ? Icons.check_circle_outline : Icons.cancel_outlined;
    final text = isTaken ? 'Marked as Taken' : 'Marked as Skipped';

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, color: fg),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _OutlineButton(
          label: 'Undo',
          icon: Icons.undo,
          onPressed: onUndo,
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final bool leftHandMode;
  final VoidCallback onTaken;
  final VoidCallback onSkip;

  const _ActionButtonsRow({
    required this.leftHandMode,
    required this.onTaken,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final takenButton = Expanded(
      child: _FilledButton(
        label: 'Taken',
        color: const Color(0xFF16A34A),
        onPressed: onTaken,
      ),
    );

    final skipButton = _OutlineButton(
      label: 'Skip',
      icon: null,
      onPressed: onSkip,
    );

    final children = leftHandMode
        ? <Widget>[skipButton, const SizedBox(width: 12), takenButton]
        : <Widget>[takenButton, const SizedBox(width: 12), skipButton];

    return Row(children: children);
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _FilledButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return SizedBox(
        height: 56,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF374151),
            side: const BorderSide(width: 2, color: Color(0xFFD1D5DB)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
    }

    return SizedBox(
      height: 56,
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF374151),
          side: const BorderSide(width: 2, color: Color(0xFFD1D5DB)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

/// ===== Appointments =====

class _AppointmentsCard extends StatelessWidget {
  final List<Appointment> appointments;
  final VoidCallback onViewAll;
  final VoidCallback onTapItem;

  const _AppointmentsCard({
    required this.appointments,
    required this.onViewAll,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: "Today's Appointments",
      leadingIcon: Icons.calendar_month_outlined,
      leadingColor: const Color(0xFF16A34A),
      onViewAll: onViewAll,
      children: appointments.map((apt) {
        return InkWell(
          onTap: onTapItem,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        apt.provider,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Color(0xFF6B7280)),
                          const SizedBox(width: 6),
                          Text(apt.time, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              apt.location,
                              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// ===== Empty State =====

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      padding: const EdgeInsets.all(32),
      child: const Column(
        children: [
          SizedBox(height: 4),
          CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFFDCFCE7),
            child: Icon(Icons.check_circle_outline, size: 32, color: Color(0xFF16A34A)),
          ),
          SizedBox(height: 16),
          Text(
            'All Caught Up!',
            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF111827)),
          ),
          SizedBox(height: 8),
          Text(
            'No medications or appointments due right now.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

/// ===== Shared Card shells =====

class _CardShell extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _CardShell({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 1),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Color leadingColor;
  final VoidCallback onViewAll;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.leadingIcon,
    required this.leadingColor,
    required this.onViewAll,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 1),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(leadingIcon, color: leadingColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                  ),
                ),
                TextButton(
                  onPressed: onViewAll,
                  child: const Text(
                    'View All',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _withDividers(children),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _withDividers(List<Widget> items) {
  if (items.isEmpty) return items;
  final out = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    out.add(items[i]);
    if (i != items.length - 1) {
      out.add(const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Divider(height: 1, color: Color(0xFFF3F4F6)),
      ));
    }
  }
  return out;
}

/// ===== Helpers =====

String _yyyyMmDd(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

String _formatTodayDate(DateTime d) {
  const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final wd = weekdays[d.weekday - 1];
  final mo = months[d.month - 1];
  return '$wd, $mo ${d.day}';
}

List<Medication> _computeDueMedications({
  required List<Medication> meds,
  required DateTime current,
}) {
  final currentMinutes = current.hour * 60 + current.minute;

  return meds.where((med) {
    return med.times.any((time) {
      final parts = time.split(':');
      if (parts.length != 2) return false;
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;
      final medTime = hour * 60 + minute;
      final diff = medTime - currentMinutes;
      return diff >= -240 && diff <= 60;
    });
  }).toList();
}
