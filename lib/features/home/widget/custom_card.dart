import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .04, vertical: MediaQuery.of(context).size.height * .004),
      color: Colors.white, 
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10)),
              onPressed: (context) {},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: ListTile(
          
          leading: Container(
             width: MediaQuery.of(context).size.width * .01,
                height: MediaQuery.of(context).size.height * .12,
            color: Colors.green,
          ),
          title: const Text('Name'),
          subtitle: const Text('Details'),
          trailing: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
