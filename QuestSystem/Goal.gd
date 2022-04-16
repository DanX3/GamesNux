extends Resource

class_name Goal
enum named {a, b, c}
export (String) var unlockSignal
export (Array) var params
export (String) var actionSignal
export (Array) var actionsParams

func onUnlockSignal(param0, param1, param2, param3):
	if len(params) > 0 and params[0] != param0:
		return
	
	if len(params) > 1 and params[1] != param1:
		return
	
	if len(params) > 2 and params[2] != param2:
		return
		
	if len(params) > 3 and params[3] != param3:
		return
	
	if actionSignal.empty():
		return
	
	if len(actionsParams) > 3:
		emit_signal(actionSignal, params[0], params[1], params[2], params[3])
	if len(actionsParams) > 2:
		emit_signal(actionSignal, params[0], params[1], params[2])
	elif len(actionsParams) > 1:
		emit_signal(actionSignal, params[0], params[1])
	elif len(actionsParams) > 0:
		emit_signal(actionSignal, params[0])
	else:
		emit_signal(actionSignal)

		
