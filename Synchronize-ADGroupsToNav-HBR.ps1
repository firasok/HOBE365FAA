
    #NCO - PowerShell Script by Netcompany. The script handles sync of AD users to Dynamics 365 Business .
    # IMPORTANT: Consider the values for the array $EnvironmentsToUpdate if any changes for Navision instances / company name occurs
    Import-Module -Name "C:\Program Files\Microsoft Dynamics 365 Business Central\150\Service\NavAdminTool.ps1"
        

    $inputEnvironment = "TEST"
           
    # Environment settings for develop, test, and production:
    $EnvironmentsToUpdate  = @()
    switch ($inputEnvironment)
    {
          'TEST'
          {
          #                                Nav Server Instance:   Navision Company Name: 
          $EnvironmentsToUpdate += ,@(10, 'TESTBC150',        'HBR Test & Uddannelse')
          }
          'PROD'
          {
          #$EnvironmentsToUpdate += ,@(20, 'HBRPROD',             'Netcompany Denmark')
          }
        }

    # Functions
    Function Get-ADNestedGroups
    {
    [cmdletbinding()]

    Param
    (
        [Parameter(Mandatory=$true, HelpMessage="Please provide a valid identity.")]$Identity
        )

    # Get all groups/users of the root group.
    $Members = Get-ADGroupMember -Identity $Identity;

    # Foreach member in the group.
    Foreach($Member in $Members)
    {
        # If the member is a group.
        If($Member.ObjectClass -eq "group")
        {
        # Run the function recursively again against the group.
        $Users += Get-ADNestedGroups -Identity $Member.distinguishedName;
        }
             
        else

        {
        $Users += @($Member); 
        }
    }

    #Return the users
    Return ,$Users;

    }

    Function CreateNavisionSuperUser
    {

        $ADSuperUserDetail = Get-ADUser -Identity $ADSuperUser

        if ($NAVUserSIDs -notcontains $ADSuperUserDetail.SID) 
        {
         New-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $ADSuperUserDetail.SamAccountName -FullName $ADSuperUserDetail.Name -LicenseType Full
         New-NAVServerUserPermissionSet -ServerInstance $ServerInstance -WindowsAccount $ADSuperUserDetail.SamAccountName -PermissionSetId SUPER
         $NAVUserSIDs += $ADSuperUserDetail.SID
        } 

        else 

        {  
         $NAVUserPermissionSets = Get-NAVServerUserPermissionSet -ServerInstance $ServerInstance -Sid $ADSuperUserDetail.SID
         foreach ($NAVUserPermissionSet in $NAVUserPermissionSets) 
         {
           if (($NAVUserPermissionSet.PermissionSetID -ne '') -AND ($NAVUserPermissionSet.PermissionSetID -ne 'SUPER')) {
             Remove-NAVServerUserPermissionSet -ServerInstance $ServerInstance -PermissionSetId $NAVUserPermissionSet.PermissionSetID -CompanyName $NAVUserPermissionSet.CompanyName -WindowsAccount $ADSuperUserDetail.SamAccountName -Force
           }
         }
         $NAVUserPermissionSets = Get-NAVServerUserPermissionSet -ServerInstance $ServerInstance -Sid $ADSuperUserDetail.SID
         if ($NAVUserPermissionSets.PermissionSetID -ne 'SUPER') 
         {
           New-NAVServerUserPermissionSet -ServerInstance $ServerInstance -WindowsAccount $ADSuperUserDetail.SamAccountName -PermissionSetId SUPER     
         }
         Set-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $ADSuperUserDetail.SamAccountName -ContactEmail $ADSuperUserDetail.Mail -FullName $ADSuperUserDetail.Name -LicenseType Full -State Enabled -ExpiryDate $NoExpiryDate
        }
        }

    Function CreateNavisionWindowsGroups
    {
        foreach ($ADGroup in $NavADGroups) 
        {
          $ADGroupDetail = Get-ADGroup -Identity $ADGroup -Properties SamAccountName,Name,SID
          if ($NAVUserSIDs -notcontains $ADGroupDetail.SID) 
         {
           New-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $ADGroupDetail.SamAccountName -FullName $ADGroupDetail.Name -LicenseType WindowsGroup
           $NAVUserSIDs += $ADGroupDetail.SID
         }
         else
         {
           Set-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $ADGroupDetail.SamAccountName -FullName $ADGroupDetail.Name -LicenseType WindowsGroup -State Enabled -ExpiryDate $NoExpiryDate
         }
        }
        } 

    # Init
    $ADusers = @()
    [datetime]$NoExpiryDate = Get-Date -Year 9999 -Day 1 -Month 1 -Minute 0 -Hour 0 -Second 0 -Millisecond 0
    $ADSuperUser =  'SVC-BC-TEST'                   
    $NavADGroups  = 'G-SE-HBR-BC-Super',
                    'G-SE-HBR-BC-Bogholder',
                    'G-SE-HBR-BC-Budget',
                    'G-SE-HBR-BC-Indkøb',
                    'G-SE-HBR-BC-Salg',
                    'G-SE-HBR-BC-Teknik',
                    'G-SE-HBR-BC-Regnskab'

    Import-Module -Name ActiveDirectory

    # Get a total list of every AD user within the AD groups, both enabled and disabled users
    foreach($NavADGroup in $NavADGroups)  
    {  
          $ADusers += Get-ADNestedGroups $NavADGroup
        }

    $ADusers =  $ADusers | select -Unique

    foreach($Environment in $EnvironmentsToUpdate)  
    {
 
          #  Init
          $ServerInstance = $Environment.Item(1)
          $NavCompanyName = $Environment.Item(2)     

          # Get list of all existing Navision users
          $NAVUsers = Get-NAVServerUser -ServerInstance $ServerInstance
          $NAVUserSIDs = @()
          foreach ($NAVUser in $NAVUsers)
          {
            $NAVUserSIDs += $NAVUser.WindowsSecurityID  
          }

          # Pre-run - Before updating each user
          CreateNavisionSuperUser
          CreateNavisionWindowsGroups
          Invoke-NAVCodeunit -ServerInstance $ServerInstance -CodeunitId 51200 -CompanyName $NAVCompanyName -MethodName PowerShellOnBeforeRun 

 
          # Updating users in Navision
          foreach ($ADUser in $ADUsers) 
          {
            
            # Update users table in Navision
            $NavUserDetails = Get-ADUser -Identity $ADUser.SID -Properties SID,Title,SamAccountName,enabled,Name,Mail,DistinguishedName      
            if ($NAVUserSIDs -notcontains $NavUserDetails.SID) 
            {
              New-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $NavUserDetails.SamAccountName -ContactEmail $NavUserDetails.Mail -FullName $NavUserDetails.Name -LicenseType Full
              $NAVUserSIDs += $NavUserDetails.SID
            }

            if ($NavUserDetails.enabled -eq 'true') 
            {
              Set-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $NavUserDetails.SamAccountName -ContactEmail $NavUserDetails.Mail -FullName $NavUserDetails.Name -LicenseType Full -State Enabled
            }
            else
            {
              Set-NAVServerUser -ServerInstance $ServerInstance -WindowsAccount $NavUserDetails.SamAccountName -ContactEmail $NavUserDetails.Mail -FullName $NavUserDetails.Name -LicenseType Full -State Disabled
            }
        
            # Update other Navision user data (resources, employee, vendors etc.)
            <#
             Build parameter list for Navision for every user.  The sequence and value is mandatory
  
               Sequence No.    Parameter
               1               SID
               2               Username
            #>

            $Parameter = $NavUserDetails.SID.value + ',' + $NavUserDetails.SamAccountName
            Invoke-NAVCodeunit -ServerInstance $ServerInstance -CodeunitId 51200 -CompanyName $NAVCompanyName -MethodName PowerShellOnRun -Argument $Parameter    
          }
    
          # Post-run - After updating users
          Invoke-NAVCodeunit -ServerInstance $ServerInstance -CodeunitId 51200 -CompanyName $NAVCompanyName -MethodName PowerShellOnAfterRun

        }