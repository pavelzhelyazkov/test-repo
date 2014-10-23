# Get all directory objects recursively

function Get-ChildItemToDepth {
  param(
    [String]$Path = $PWD,
    [String]$Filter = "*",
    [Byte]$ToDepth = 255,
    [Byte]$CurrentDepth = 0,
    [Switch]$DebugMode
  )
 
  $CurrentDepth++
  if ($DebugMode) { $DebugPreference = "Continue" }
 
  Get-ChildItem $Path | ForEach-Object {
    $_ | Where-Object { $_.Name -like $Filter }
 
    if ($_.PsIsContainer) {
      if ($CurrentDepth -le $ToDepth) {
        # Callback to this function
        Get-ChildItemToDepth -Path $_.FullName -Filter $Filter -ToDepth $ToDepth -CurrentDepth $CurrentDepth
      } else {
        Write-Debug $("Skipping GCI for Folder: $($_.FullName) " +
          "(Why: Current depth $CurrentDepth vs limit depth $ToDepth)")
      }

    }

  }

}

Function sGet-AllFolders($rootFolder) {

  $allFolders = Get-ChildItem -Recurse -Path "$rootFolder" `
                | Where-Object {$_.PSIsContainer -eq $True}

  return $allFolders
  
}

# Get all folders under a folder

Function sGet-LvlOneFolders($rootFolder) {

  $lvlOneFolders = Get-ChildItem -Path "$rootFolder" `
                     | Where-Object {$_.PSIsContainer -eq $True}

  return $lvlOneFolders

}
