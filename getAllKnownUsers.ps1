class user{
  [string]$SID
  [string]$User
}

$profileList = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'

$SidList = (Get-ChildItem $profileList | Select-Object -Property Name | Split-Path -Leaf).Replace('}','')

$AllKnownUsers = $SidList.ForEach({
  if($PSItem.Length -gt 10){
    [user]@{
    SID = $PSItem
    User = $((Get-ItemProperty "$profileList\$PSItem" | Select-Object -ExpandProperty profileimagepath).Replace('C:\Users\',''))
    }
  }
})
