enemyPower = 1
enemyPowerFunction = function (input) { return power(1.07, input) - (0.05 * input) }
enemyLevel = 1

enemyLevelUpRoom = 3
playerLevelUpRoom = 5

normalRooms = scr_get_objects_of_tag("normalPrison")
previousRoom = noone
roomNumber = 1