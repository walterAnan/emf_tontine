class SelectedListItem {
  bool? isSelected;
  String name;
  String? value;

  SelectedListItem({
    required this.name,
    this.value,
    this.isSelected,
  });
  factory SelectedListItem.fromMap(Map<String, dynamic> jason)=>
      SelectedListItem(
          isSelected: jason['isSelected'],
          name: jason['name'],
          value: jason['value']

      );
}