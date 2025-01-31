class_name Date

var years: int
var months: int

func _init(years: int = 0, months: int = 0) -> void:
	self.years = years
	self.months = months

func _get_months() -> int:
	return years * 12 + months

func _months_between(right: Date) -> int:
	return right._get_months() - self._get_months()

func _add_months(months_to_add: int) -> Date:
	var months := self.months
	var years := self.years
	months += months_to_add
	var additional_years := months / 12
	months -= additional_years * 12
	years += additional_years
	return Date.new(years, months)
	

func lerp_date(right: Date, value: float) -> Date:
	var months = self._months_between(right)
	var months_to_add = ceil(months * value)
	print(str("Months ", months, "Value", value, "Months to Add ", months_to_add))
	return self._add_months(months_to_add)

func _to_string() -> String:
	return str(years, "年", months, "月")
