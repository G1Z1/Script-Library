#Connect-MgGraph -Scopes "Group.ReadWrite.All", "Device.ReadWrite.All"
#"DeviceManagementManagedDevice.PrivilegedOperations.All"

$win10list = @()
$win10list += (Get-MgGroupMember -GroupId a4c214f8-cf12-418a-bb48-78145a559589).Id
Write-Host "Win10 members: `n"
foreach ($member in $win10list){
     $member = (Get-MgDevice -Filter "Id eq '$member'").DisplayName
     Write-Host $member
} 
Write-Host "`nTest members: `n"
$testlist = @()
$testlist += (Get-MgGroupMember -GroupId ad0f5820-ca0e-40a2-a1c6-806bdce45775).Id
foreach ($member in $testlist){
     $member = (Get-MgDevice -Filter "Id eq '$member'").DisplayName
     Write-Host $member
} 

foreach ( $member in $win10list){     
     if ($member -NotIn $testlist){
          $member = (Get-MgDevice -Filter "Id eq '$member'").DisplayName
          Write-Host `n$member 'not in Test'
     }
}

Write-Host "`nAdding missing members:`n"

foreach ($member in $win10list){     
     if ($member -NotIn $testlist){
          New-MgGroupMember -GroupId ad0f5820-ca0e-40a2-a1c6-806bdce45775 -DirectoryObjectId $member
          if ($member -In $testlist){
               $member = (Get-MgDevice -Filter "Id eq '$member'").DisplayName
               Write-Host `n$member ' in Test'
          }
          else{
               $member = (Get-MgDevice -Filter "Id eq '$member'").DisplayName
               Write-Host `n$member 'not in Test'
          }
          
          
     }
}
$testlist