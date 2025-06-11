import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;
  const ExpandableDescription({super.key, required this.description});

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool isExpanded = false;
  bool showReadMore = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final span = TextSpan(
      text: widget.description,
      style: const TextStyle(fontSize: 14, height: 1.5),
    );
    final tp = TextPainter(
      text: span,
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 40); // Adjust for padding
    if (tp.didExceedMaxLines != showReadMore) {
      setState(() => showReadMore = tp.didExceedMaxLines);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description.isNotEmpty ? widget.description : 'No Description',
          style: const TextStyle(fontSize: 14, height: 1.5),
          maxLines: isExpanded ? null : 3,
          overflow: TextOverflow.fade,
        ),
        if (showReadMore)
          TextButton(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            child: Text(isExpanded ? 'Read Less' : 'Read More'),
          ),
      ],
    );
  }
}
