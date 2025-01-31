extends Node

enum Achievement {
	# School Period
	ENTER_THE_ARENA,
	ASCENSION,
	
	# Game Jam 1
	GREENPATH,
	ONE_LAST_DRINK,
	
	# Kyoto University Period
	UPBEET,
	SLEEPWALKER,
	
	# Game Jam 2 - Lightning Round?
	THE_SHACKLED,
	BEANS_FOR_GOOD,
	TIDE,
	RE_COLLECT,
	HUNDRED_LITTLE_GUYS,
	SWIRLY_WHIRLY
}

signal on_achievement(achievement: Achievement)

func activate(achievement: Achievement) -> void:
	on_achievement.emit(achievement)
