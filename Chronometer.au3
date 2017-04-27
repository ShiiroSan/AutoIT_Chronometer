;*****************************************
;Chronometer.au3 by ShiiroSan
;Créé avec ISN AutoIt Studio v. 1.04
;*****************************************

#include "Forms\Chronometer_GUI.isf"

GUISetState(@SW_SHOW,$Chronometer_GUI)
$fullTime=0
$isRunning=False
$pinned = False
TrayTip("Tips!","You should place the chronometer to the place where you can see it. Moving the window can results in losing seconds...",10)
While 1
	$startedTimer=TimerInit()
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $actionBtn
			If $isRunning Then
				$fullTime=0
				$isRunning = False
				GUICtrlSetData($actionBtn, "Start")
				GUICtrlSetColor($timeLabel, 0xFF0000)
			Else ;Si le timer n'est pas en marche, on l'active
				$isRunning = True
				GUICtrlSetData($timeLabel, milliToRealTime(0))
				GUICtrlSetData($actionBtn, "Stop")
				GUICtrlSetColor($timeLabel, 0x32A600)
			EndIf
		Case $pinBtn
			If $pinned Then
				WinSetOnTop($Chronometer_GUI, "", 0)
				$pinned = False
			Else
				WinSetOnTop($Chronometer_GUI, "", 1)
				$pinned = True
			EndIf
	EndSwitch
	Sleep(10)
	If $isRunning Then
		$fullTime = $fullTime + TimerDiff($startedTimer)
		GUICtrlSetData($timeLabel, milliToRealTime($fullTime))
	EndIf
WEnd

func milliToRealTime($milliTime)
	$secondes = int(Mod(($milliTime / 1000), 60))
	$minutes = int(Mod(($milliTime / (60*1000)), 60))
	$heures = int(Mod(($milliTime / (60*60*1000)), 24))
	If $secondes < 10 Then $secondes = "0"&$secondes
	If $minutes < 10 Then $minutes = "0"&$minutes
	If $heures < 10 Then $heures = "0"&$heures
	Return $heures&":"&$minutes&":"&$secondes
EndFunc