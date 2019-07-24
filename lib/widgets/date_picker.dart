import 'package:flutter/material.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: Theme.of(context).textTheme.subhead.fontSize)
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.calendar_today,
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.onSelectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      onSelectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
      ],
    );
  }
}
