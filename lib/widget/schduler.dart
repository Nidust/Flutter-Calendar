import 'package:calendar_scheduler/models/schdule.dart';
import 'package:calendar_scheduler/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schduler extends StatelessWidget {
  const Schduler({
    super.key,
    required this.selectedDay,
    required this.schduleList,
    required this.onDismissed,
  });

  final DateTime? selectedDay;
  final List<Schdule> schduleList;
  final void Function(int index) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SchdulerHeader(
          selectedDay: selectedDay,
          schduleCount: schduleList.length,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 210,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.vertical,
            itemCount: schduleList.length,
            itemBuilder: (context, index) {
              var schdule = schduleList[index];

              return _SchdulerTile(
                index: index,
                schdule: schdule,
                onDismissed: onDismissed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SchdulerHeader extends StatelessWidget {
  const _SchdulerHeader({
    Key? key,
    required this.selectedDay,
    required this.schduleCount,
  }) : super(key: key);

  final DateTime? selectedDay;
  final int schduleCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: AppColor.noonCloud,
        border: Border.symmetric(
          vertical: BorderSide(color: AppColor.noonCloud),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedDay != null
                ? Text(
                    DateFormat("yyyy년 MM월 dd일").format(selectedDay!),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                : Container(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$schduleCount개",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SchdulerTile extends StatelessWidget {
  const _SchdulerTile({
    Key? key,
    required this.index,
    required this.schdule,
    required this.onDismissed,
  }) : super(key: key);

  final int index;
  final Schdule schdule;
  final void Function(int index) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(schdule),
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      secondaryBackground: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Icon(Icons.delete_forever),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDismissed(index);
        }
      },
      confirmDismiss: (DismissDirection dir) async {
        return dir == DismissDirection.endToStart;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.noonSun),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Text(
                    "${DateFormat("MM/dd").format(schdule.startDay)} ~ ${DateFormat("MM/dd").format(schdule.endDay)}",
                  ),
                  Text(
                    schdule.title,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
