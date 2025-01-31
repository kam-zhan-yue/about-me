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

func _add_months(months_to_add: int) -> Date:
	var m := self.months
	var y := self.years
	m += months_to_add
	var additional_years := int(m / 12)
	m -= additional_years * 12
	y += additional_years
	return Date.new(y, m)
	

func lerp_date(right: Date, value: float) -> Date:
	var m = self._months_between(right)
	var months_to_add = ceil(m * value)
	var date = self._add_months(months_to_add)
	return date

func _to_string() -> String:
	return str(years, "年", months, "月")
