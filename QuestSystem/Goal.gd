extends Resource

class_name Goal
signal reached

export (String) var unlockSignal
export (Array) var unlockParams
export (String) var actionSignal
export (Array) var actionsParams

func onUnlockSignal(action, params):
	if not _validate(params):
		return
	
	if actionSignal.empty():
		emit_signal("reached")
	
	if len(actionsParams) > 3:
		emit_signal('reached', actionSignal, actionsParams[0], actionsParams[1], actionsParams[2], actionsParams[3])
	if len(actionsParams) > 2:
		emit_signal('reached', actionSignal, actionsParams[0], actionsParams[1], actionsParams[2], null)
	elif len(actionsParams) > 1:
		emit_signal('reached', actionSignal, actionsParams[0], actionsParams[1], null, null)
	elif len(actionsParams) > 0:
		emit_signal('reached', actionSignal, actionsParams[0], null, null, null)
	else:
		emit_signal('reached', actionSignal, null, null, null, null)


func _validate(params):
	return true
