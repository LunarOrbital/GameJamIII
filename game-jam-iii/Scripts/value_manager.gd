extends Node
var useFPO : bool = true
var extraPlanets : bool = true
var spawnCount : int = 1
var easy:=false
var mid:= false
var hard:= false
var eye:= false
var plinko := false

func _update_values(useFPO2 : bool, extraPlanets2 : bool, spawnCount2 : int) -> void:
	useFPO = useFPO2
	extraPlanets =extraPlanets2
	spawnCount = spawnCount2

func _update_stars(str2:String) -> void:
	if str2 == "easy":
		easy = true
	if str2 == "mid":
		mid = true
	if str2 == "hard":
		hard = true
	if str2 == "eye":
		eye = true
	if str2 == "plinko":
		plinko = true

	
