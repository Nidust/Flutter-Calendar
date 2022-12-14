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
  final Future<List<Schdule>> schduleList;
  final void Function(Schdule index) onDismissed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: schduleList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SchdulerHeader(
                  selectedDay: selectedDay,
                  schduleCount: 0,
                ),
                const SizedBox(
                  width: double.maxFinite,
                  height: 210,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.noonSun),
                  ),
                ),
              ],
            );
          default:
            return _renderList(snapshot.data);
        }
      },
    );
  }

  Widget _renderList(List<Schdule>? data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SchdulerHeader(
          selectedDay: selectedDay,
          schduleCount: data == null ? 0 : data.length,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 210,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.vertical,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              var schdule = data![index];

              return _SchdulerTile(
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
                    DateFormat("yyyy??? MM??? dd???").format(selectedDay!),
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
              "$schduleCount???",
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
    required this.schdule,
    required this.onDismissed,
  }) : super(key: key);

  final Schdule schdule;
  final void Function(Schdule index) onDismissed;

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
          onDismissed(schdule);
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
