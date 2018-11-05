#region Script preferences
#Remove cached variables
#Remove-Variable * -ErrorAction SilentlyContinue;

#Error preferences
$WarningPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"
#endregion

#region Azure Login.
#Login-AzureRmAccount
#$Subscription              = Get-AzureRmSubscription | Out-GridView -Title "Select the Azure subscription..." -PassThru
#Select-AzureRmSubscription -SubscriptionId $Subscription.SubscriptionId
#endregion

#region Parameters
$RG_Name=      'test02'
$location=     'eastus'
$paramUri=    'C:\Users\Administrator\Documents\GE_IN\v2\Params.json'
$masterTemplateUri=  'https://raw.githubusercontent.com/sandeephanu/CoolStuff/master/in/master.json'

#Check or Create Resource group
Get-AzureRmResourceGroup -Name $RG_Name -ev notPresent -ea 0
if ($notPresent) { Write-Host "Failover RG '$RG_Name' does not exist.Creating new in $location..." -ForegroundColor Yellow
New-AzureRmResourceGroup -Name $RG_Name -Location $location
} else { Write-Host "Using existing resource group '$RG_Name'"-ForegroundColor Yellow ;}

#region deploy
New-AzureRmResourceGroupDeployment -ResourceGroupName $RG_Name -Mode Incremental -TemplateParameterFile $paramUri -TemplateUri $masterTemplateUri -Verbose
#endregion
