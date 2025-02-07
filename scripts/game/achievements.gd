extends Node

enum Event {
	NONE,
	SCHOOL,
	KURECHII,
	UNIMELB_1,
	GAME_JAM_1,
	KYODAI,
	SCS,
	UNIMELB_2,
	GAME_JAM_2,
	FLAGPOLE,
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
	
	# University 1
	GREENPATH,
	SLEEPWALKER,
	
	# Game Jam 1
	ONE_LAST_DRINK,
	UPBEET,
	
	# Kyoto University Period
	KABADDI,
	RUGBY,
	
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
	Achievement.KABADDI: preload("res://resources/achievements/kabaddi.tres"),
	Achievement.RUGBY: preload("res://resources/achievements/rugby.tres")
}

var achievement_dict = {
	str(Date.new(2017, 4)): Achievement.FIRST_GAME,
	str(Date.new(2018, 4)): Achievement.ENTER_THE_ARENA,
	str(Date.new(2019, 6)): Achievement.TEACHING_GAMES,
	str(Date.new(2019, 9)): Achievement.ASCENSION,
	str(Date.new(2020, 11)): Achievement.GRADUATION,
	str(Date.new(2021, 11)): Achievement.POSTKNIGHT_2,
	str(Date.new(2022, 6)): Achievement.GREENPATH,
	str(Date.new(2023, 6)): Achievement.KABADDI,
	str(Date.new(2023, 8)): Achievement.RUGBY,
	str(Date.new(2023, 11)): Achievement.DEATH_GAME_HOTEL,
	str(Date.new(2024, 3)): Achievement.GAME_MAKERS_CLUB,
	str(Date.new(2024, 8)): Achievement.UPTICK,
}

signal on_achievement(data: AchievementData)
signal on_event_started(event: Event)
signal on_event_completed(event: Event)
signal on_countdown_started
signal on_countdown_completed

var active := true
var completed = {}
var completed_events = {}
var timer := 0.0
var time := 0.0
var start_date := Date.new()
var end_date := Date.new()
var current_event := Event.NONE

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
	if not active: return
	if timer < time:
		var p := timer / time
		Game.update_date(start_date.lerp_date(end_date, p))
		
		if str(Game.date) in achievement_dict:
			activate(achievement_dict[str(Game.date)])
		timer += delta
		if timer >= time:
			complete_event(current_event)
			end_sequence()


func complete_event(event: Event) -> void:
	print("Completing Event: ", get_event_id(event))
	completed_events[event] = true
	on_event_completed.emit(event)

func activate_event(event: Event) -> void:
	if event in completed_events:
		return
	print("Activating: ", get_event_id(event))
	on_event_started.emit(event)
	current_event = event
	if event == Event.SCHOOL:
		school_sequence()
	elif event == Event.KURECHII:
		kurechii_sequence()
	elif event == Event.SCS:
		scs_sequence()
	elif event == Event.KYODAI:
		kyodai_sequence()
	elif event == Event.UNIMELB_1:
		university_sequence_1()
	elif event == Event.UNIMELB_2:
		university_sequence_2()

func school_sequence() -> void:
	var start = Date.new(2008, 1)
	var end = Date.new(2020, 12)
	start_countdown(start, end, 6.0)

func kurechii_sequence() -> void:
	var start = Date.new(2021, 2)
	var end = Date.new(2022, 1)
	start_countdown(start, end, 3.0)
	
func university_sequence_1() -> void:
	var start = Date.new(2022, 1)
	var end = Date.new(2023, 1)
	start_countdown(start, end, 2.0)

func kyodai_sequence() -> void:
	var start = Date.new(2023, 4)
	var end = Date.new(2023, 8)
	start_countdown(start, end, 2.0)
	
func scs_sequence() -> void:
	var start = Date.new(2023, 8)
	var end = Date.new(2024, 1)
	start_countdown(start, end, 2.0)
	
func university_sequence_2() -> void:
	var start = Date.new(2024, 2)
	var end = Date.new(2024, 9)
	start_countdown(start, end, 2.0)

func start_countdown(start: Date, end: Date, duration: float) -> void:
	self.on_countdown_started.emit()
	await Game.player.fade_out()
	# Wait one more due to UI
	await Global.wait_fade()
	self.start_date = start
	self.end_date = end
	self.timer = 0.0
	self.time = duration
	

func end_sequence() -> void:
	self.on_countdown_completed.emit()
	await Game.player.fade_in()

func has_completed(event: Event) -> bool:
	return event in completed_events
