Scriptname KudasaiMCM extends SKI_ConfigBase

; --------------------- Properties
; ----------- Geeneral

bool Property bEnabled = true Auto Hidden

int Property iHunterPrideKey Auto Hidden
int Property iSurrenderKey Auto Hidden

bool Property bNotifyDefeat Auto Hidden
bool Property bNotifyDestroy Auto Hidden
bool Property bNotifyColored Auto Hidden
int Property iNotifyColorChoice Auto Hidden

; ----------- Combat

bool Property bMidCombatAssault Auto Hidden
bool Property bPostCombatAssault Auto Hidden


; ----------- NSFW

; --------------------- Menu

int Function GetVersion()
	return 1
endFunction

Event OnConfigInit()
  Pages = new String[2]
  Pages[0] = "$YK_General"
  Pages[1] = "$YK_Combat"
EndEvent

Event OnPageReset(string page)
  SetCursorFillMode(TOP_TO_BOTTOM)
  If (page == "")
    page = "$YK_General"
  EndIf
  If (page == "$YK_General")
    AddToggleOptionST("enabled", "$YK_Enabled", bEnabled)
    AddHeaderOption("$YK_Hotkeys")
    AddKeyMapOptionST("hunterpridekey", "$YK_HunterPrideKey", iHunterPrideKey)
    AddKeyMapOptionST("surrenderkey", "$YK_SurrenderKey", iSurrenderKey)
    SetCursorPosition(1)
    AddHeaderOption("$YK_Notification")
    AddToggleOptionST("notifydefeat", "$YK_NotifyDefeat", bNotifyDefeat)
    AddToggleOptionST("notifydestroy", "$YK_NotifyDestry", bNotifyDestroy) ; as in item destruction
		AddToggleOptionST("notifycolored", "$YK_NotifyColored", bNotifyColored, getFlag(bNotifyDefeat || bNotifyDestroy))
    AddColorOptionST("notifycolorchoice", "$YK_NotifyColorChoice", iNotifyColorChoice, getFlag((bNotifyDefeat || bNotifyDestroy) && bNotifyColored))

  ElseIf (page == "$YK_Combat")
    AddHeaderOption("$YM_Assault")
    AddToggleOptionST("midcmbtassault", "$YK_MidCmbtAssault", bMidCombatAssault)
    AddToggleOptionST("postcmbtassault", "$YK_PostCmbtAssault", bPostCombatAssault)
    AddHeaderOption("$YK_MidCombat")
    SetCursorPosition(1)
    AddHeaderOption("$YK_PostCombat")

  ElseIf (page == "$YK_NSFW")

  ElseIf(page == "$YK_Debug")

  EndIf
EndEvent

; --------------------- State Options

Event OnSelectST()
  String[] s = StringUtil.Split(GetState(), "_")
  If(s[0] == "enabled")
    bEnabled = !bEnabled
    SetToggleOptionValueST(bEnabled)
  EndIf
EndEvent

Event OnHighlightST()
  String[] s = StringUtil.Split(GetState(), "_")
  If(s[0] == "enabled")
  SetInfoText("$YK_EnabledInfo")
  EndIf
EndEvent

; --------------------- Misc

; Event OnConfigOpen()
;   config = JValue.retain(JValue.readFromFile(filepath))
; EndEvent
; Event OnConfigClose()
;   JValue.writeToFile(config, filepath)
;   config = JValue.release(config)
;   ReadSettings(filepath)
; EndEvent

int Function getFlag(bool option)
	If(option)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction