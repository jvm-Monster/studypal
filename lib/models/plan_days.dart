class PlanDays{
  List<Map<String,dynamic>> monday=[];
  List<Map<String,dynamic>> tuesday=[];
  List<Map<String,dynamic>> wednesday=[];
  List<Map<String,dynamic>> thursday=[];
  List<Map<String,dynamic>> friday=[];
  List<Map<String,dynamic>> saturday=[];
  List<Map<String,dynamic>> sunday=[];

  PlanDays(
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday);

  // Convert PlanDays to Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'monday':monday,
      'tuesday':tuesday,
      'wednesday':wednesday,
      'thursday':thursday,
      'friday':friday,
      'saturday':saturday,
      'sunday':sunday
    };
  }

  // Create PlanDays from Map during deserialization
  factory PlanDays.fromMap(Map<String, dynamic> map) {
    return PlanDays(
      map['monday'],
      map['tuesday'],
      map['wednesday'],
      map['thursday'],
      map['friday'],
      map['saturday'],
      map['sunday'],
    );
  }

  @override
  String toString() {
    return 'PlanDays{monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday}';
  }
}