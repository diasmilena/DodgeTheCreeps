extends CanvasLayer

signal start_game


func _ready():
	$ScoreLabel.hide()

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel/animacao.play("labelEfeito");
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	$ScoreLabel/animacao.play("ScoreAnimationDesaparecer")
	yield($MessageTimer, "timeout") #começa o timer
	$MessageLabel.rect_position += Vector2(-450, 0)
	$MessageLabel/animacao.play("labelVir")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.margin_left = - 184
	$StartButton/animacao.play("AnimationStart")
	$StartButton.show()
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func update_record_score(recordScore):
	$RecordScoreLabel2.text = str(recordScore)
	$Label/animacao.play("recordAnimation")
	$RecordScoreLabel2/animacao2.play("recordAnimation")

func _on_StartButton_pressed():
	emit_signal("start_game")
	$StartButton.hide()
	$ScoreLabel/animacao.play("ScoreAnimationAparecer")
	$ScoreLabel.show() #eu que adicionei
	
