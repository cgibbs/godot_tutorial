extends Node

var collected_coins = 0
var total_coins = 0
@onready var coin_count_label: Label = %CoinCountLabel

func _ready() -> void:
	update_coin_count()

func update_coin_count() -> void:
	# don't just increment, in case weirdness with save/load happens later
	
	# updating this can be useful if some in-game event adds more coins to the levels,
	# e.g. a post-game challenge mode
	total_coins = get_tree().get_node_count_in_group("Coins")
	collected_coins = 0
	for coin in get_tree().get_nodes_in_group("Coins"):
		if coin.collected:
			collected_coins += 1

	print("collected " + str(collected_coins) + " out of " + str(total_coins) + " coins.")
	coin_count_label.text = str(collected_coins) + "/" + str(total_coins)

	for portal in get_tree().get_nodes_in_group("Portals"):
		portal.check_coin_count_reached(collected_coins)
