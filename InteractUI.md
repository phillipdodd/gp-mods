From Dan Snd

```
UI.AddInteractUI(string sprite, string text)
```

That adds a interact ui to the bottom of the string like the item shifter and the minigames do

When you're done with it call 

```
UI.ClearInteractUIs()
``` 

on sprite string you can call some pre-defined sprites or any sprites that you introduced yourself in your mod

predefined sprites
```
case "alt":
    desiredSprite = ResourcesManager.get.AltButtonSprite;
    break;
case "e":
    desiredSprite = ResourcesManager.get.EButtonSprite;
    break;
case "f":
    desiredSprite = ResourcesManager.get.FButtonSprite;
    break;
case "q":
    desiredSprite = ResourcesManager.get.QButtonSprite;
    break;
case "r":
    desiredSprite = ResourcesManager.get.RButtonSprite;
    break;
case "shift":
    desiredSprite = ResourcesManager.get.ShiftButtonSprite;
    break;
case "space":
    desiredSprite = ResourcesManager.get.SpaceButtonSprite;
    break;
case "ctrl":
    desiredSprite = ResourcesManager.get.ControlButtonSprite;
    break;
case "mmb":
    desiredSprite = ResourcesManager.get.MiddleMousebuttonSprite;
    break;
```
there is also
```
UI.SetSecondaryInteractable()

SetSecondaryInteractableInfo(string text, string sprite = "")

SetTerciaryInteractable()

SetTerciaryInteractableInfo(string text, string sprite = "")

SetQuadInteractable()

SetQuadInteractableInfo(string text, string sprite = "")
```