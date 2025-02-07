class_name Date
extends Object

var years: int
var months: int

func _init(y: int = 0, m: int = 0) -> void:
	self.years = y
	self.months = m

func _get_months() -> int:
	return years * 12 + months

func _months_between(right: Date) -> int:
	return right._get_months() - self._get_months()
	

func lerp_date(right: Date, value: float) -> Date:
	var m = self._months_between(right)
	var months_to_add = floor(m * value)
	var total_months = months_to_add + self._get_months()
	var date = Global.from_months(total_months)
	return date

func _to_string() -> String:
	return str(years, "年", months, "月")
