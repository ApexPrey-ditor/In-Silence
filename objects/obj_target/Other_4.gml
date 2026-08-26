var numTriggers = instance_number(obj_trigger)
var currentTrigger = noone
	
for (var i = 0; i < numTriggers; i++) {
	currentTrigger = instance_find(obj_trigger, i)
		
	if (currentTrigger.triggerId == nextTriggerID) {
		array_push(nextTriggers, currentTrigger)
	}
}