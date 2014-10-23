
if ($PSVersionTable.PSVersion.Major -le 3) {

  $myScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent

} else {

  $myScriptRoot = $PSScriptRoot

}

. "$myScriptRoot\acl-find-include.ps1"



# configuration parameters
$rootPath = "D:\"

#Get-ChildItemToDepth -Path $rootPath -ToDepth 1 | Where-Object { $_.PSIsContainer -eq  $True }

#exit

$lvlOneFolders = sGet-lvlOneFolders($rootPath)

#$allF.GetType()

Foreach ($folder in $lvlOneFolders) {


  $folderAcl = Get-Acl -Path $folder.FullName
  $folderAcl.Access | Where-Object { $_.AccessControlType -eq "Allow" -and $_.IdentityReference -eq "EASYCREDIT\pavel.zhelyazkov" }
  exit

}

exit

Foreach ($a in $alldirs) {

  $a | get-member
  
  exit

  $b = Get-Acl -InputObject $a
  $b.GetType()
  
  

}
