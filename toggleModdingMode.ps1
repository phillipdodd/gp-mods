# See https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7
function gp-togglemoddingmode() {
    # Thanks for pointing out needing relative path Vinapocalypse!
    $gpDir = $env:APPDATA.Replace("Roaming", '') + "\LocalLow\Bitten Toast Games\GardenPaws\"
    $existingFiles = Get-Item "$($gpDir)*"
    
    $moddingMode = $false
    $disabledModdingMode = $false
    
    # $moddingConsole = $false
    # $disabledModdingConsole = $false
    
    for ($i = 0; $i -lt $existingFiles.Count; $i++) {
        if ($existingFiles[$i].Name -eq "moddingmode.txt") {
            $moddingMode = $existingFiles[$i]
        }
        elseif ($existingFiles[$i].Name -eq "moddingmodedisabled.txt") {
            $disabledModdingMode = $existingFiles[$i]
        }
        # elseif ($existingFiles[$i].Name -eq "moddingconsole.txt") {
        #     $moddingConsole = $existingFiles[$i]
        # }
        # elseif ($existingFiles[$i].Name -eq "moddingconsoledisabled.txt") {
        #     $disabledModdingConsole = $existingFiles[$i] 
        # }
    }
    
    if ($moddingMode -eq $false -and $disabledModdingMode -eq $false) {
        Write-Output "Modding Mode Enabled"
        New-Item -Path "$($gpDir)moddingmode.txt" 
    }
    elseif ($moddingMode -ne $false) {
        Write-Output "Modding Mode Disabled"
        $moddingMode | Rename-Item -NewName "moddingmodedisabled.txt"
    }
    elseif ($disabledModdingMode -ne $false) {
        Write-Output "Modding Mode Enabled"
        $disabledModdingMode | Rename-Item -NewName "moddingmode.txt"
    }
    
    # if ($moddingConsole -eq $false -and $disabledModdingConsole -eq $false) {
    #     New-Item -Path "$($gpDir)moddingconsole.txt" 
    # }
    # elseif ($moddingConsole -ne $false) {
    #     $moddingConsole | Rename-Item -NewName "moddingconsoledisabled.txt"
    # }
    # elseif ($disabledModdingConsole -ne $false) {
    #     $disabledModdingConsole | Rename-Item -NewName "moddingconsole.txt"
    # }
}