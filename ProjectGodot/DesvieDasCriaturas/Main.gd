extends Node

export (PackedScene) var Mob
var score
var recordScore

func _ready():
	randomize()
	$up.hide();
	$down.hide();
	$right.hide();
	$left.hide();
	recordScore = 0

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	get_tree().call_group("mobs", "queue_free")
	
	$musica.stop()
	$gameover.play()
	
	$up.hide();
	$down.hide();
	$right.hide();
	$left.hide();
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$musica.play()
	
	$up.show();
	$down.show();
	$right.show();
	$left.show();
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	
	if(score > recordScore):
		recordScore = score
		$HUD.update_record_score(recordScore)
	
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$"CaminhoTurba/LocalGeraçãoTurba".offset = randi()
	
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $"CaminhoTurba/LocalGeraçãoTurba".rotation + PI / 2
	
	mob.position = $"CaminhoTurba/LocalGeraçãoTurba".position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
