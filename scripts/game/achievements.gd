extends Node

enum Event {
	SCHOOL,
	KURECHII,
	MELBOURNE_UNI_1,
	GAME_JAM_1,
	KYOTO_UNI,
	SCS,
	MELBOURNE_UNI_2,
	GAME_JAM_2,
}

enum Achievement {
	# School Period
	FIRST_GAME,
	ENTER_THE_ARENA,
	TEACHING_GAMES,
	ASCENSION,
	GRADUATION,
	
	# Kurechii
	POSTKNIGHT_2,
	
	# Game Jam 1
	GREENPATH,
	ONE_LAST_DRINK,
	
	# Kyoto University Period
	UPBEET,
	SLEEPWALKER,
	
	# Skeleton Crew Studio
	DEATH_GAME_HOTEL,
	
	# Back to University
	GAME_MAKERS_CLUB,
	UPTICK,
	
	# Game Jam 2 - Lightning Round?
	THE_SHACKLED,
	BEANS_FOR_GOOD,
	TIDE,
	RE_COLLECT,
	HUNDRED_LITTLE_GUYS,
	SWIRLY_WHIRLY
}

var achievement_data = {
	Achievement.FIRST_GAME: preload("res://resources/achievements/1_first_game.tres"),
	Achievement.ENTER_THE_ARENA: preload("res://resources/achievements/2_enter_the_arena.tres"),
	Achievement.TEACHING_GAMES: preload("res://resources/achievements/3_teaching_games.tres"),
	Achievement.ASCENSION: preload("res://resources/achievements/4_ascension.tres"),
	Achievement.GRADUATION: preload("res://resources/achievements/5_graduation.tres"),
	Achievement.POSTKNIGHT_2: preload("res://resources/achievements/6_postknight_2.tres"),
	Achievement.GREENPATH: preload("res://resources/achievements/7_greenpath.tres"),
	Achievement.ONE_LAST_DRINK: preload("res://resources/achievements/8_one_last_drink.tres"),
	Achievement.SLEEPWALKER: preload("res://resources/achievements/9_sleepwalker.tres"),
	Achievement.UPBEET: preload("res://resources/achievements/10_upbeet.tres"),
	Achievement.DEATH_GAME_HOTEL: preload("res://resources/achievements/11_death_game_hotel.tres"),
	Achievement.GAME_MAKERS_CLUB: preload("res://resources/achievements/12_game_makers_club.tres"),
	Achievement.UPTICK: preload("res://resources/achievements/13_uptick.tres"),
	Achievement.BEANS_FOR_GOOD: preload("res://resources/achievements/14_beans_for_good.tres"),
	Achievement.THE_SHACKLED: preload("res://resources/achievements/15_the_shackled.tres"),
	Achievement.TIDE: preload("res://resources/achievements/16_tide.tres"),
	Achievement.RE_COLLECT: preload("res://resources/achievements/17_re_collect.tres"),
	Achievement.HUNDRED_LITTLE_GUYS: preload("res://resources/achievements/18_hundred_little_guys.tres"),
	Achievement.SWIRLY_WHIRLY: preload("res://resources/achievements/19_swirly_whirly.tres"),
}

var achievement_dict = {
	str(Date.new(2017, 4)): Achievement.FIRST_GAME,
	str(Date.new(2018, 4)): Achievement.ENTER_THE_ARENA,
	str(Date.new(2019, 6)): Achievement.TEACHING_GAMES,
	str(Date.new(2019, 9)): Achievement.ASCENSION,
	str(Date.new(2020, 9)): Achievement.GRADUATION,
}

signal on_achievement(data: AchievementData)

var completed = {}
var completed_events = {}
var timer := 0.0
var time := 0.0
var start_date := Date.new()
var end_date := Date.new()


func get_achievement_id(achievement: Achievement) -> String:
	return str(Achievement.keys()[achievement])
	
func get_event_id(event: Event) -> String:
	return str(Event.keys()[event])

func activate(achievement: Achievement) -> void:
	if achievement in completed:
		return
	completed[achievement] = true
	var data = achievement_data.get(achievement)
	on_achievement.emit(data as AchievementData)

func _process(delta: float) -> void:
	if timer < time:
		var p := timer / time
		Game.update_date(start_date.lerp_date(end_date, p))
		
		if str(Game.date) in achievement_dict:
			activate(achievement_dict[str(Game.date)])
		timer += delta
		if timer >= time:
			end_sequence()

func activate_event(event: Event) -> void:
	if event in completed_events:
		return
	completed_events[event] = true
	if event == Event.SCHOOL:
		school_sequence()
	elif event == Event.KURECHII:
		kurechii_sequence()
	elif event == Event.SCS:
		scs_sequence()
	elif event == Event.KYOTO_UNI:
		kyodai_sequence()
	elif event == Event.MELBOURNE_UNI_1:
		university_sequence_1()
	elif event == Event.MELBOURNE_UNI_2:
		university_sequence_2()

func school_sequence() -> void:
	await Game.player.fade_out()
	start_date = Date.new(2008, 1)
	end_date = Date.new(2021, 12)
	timer = 0.0
	time = 10.0

func kurechii_sequence() -> void:
	pass
	
func scs_sequence() -> void:
	pass

func kyodai_sequence() -> void:
	pass
	
func university_sequence_1() -> void:
	pass
	
func university_sequence_2() -> void:
	pass

func end_sequence() -> void:
	await Game.player.fade_in()

func has_completed(event: Event) -> bool:
	return event in completed_events
