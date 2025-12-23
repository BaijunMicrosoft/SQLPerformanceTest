param(
    [Parameter(Mandatory=$true)]
    [string]$AdminUsername,

    [Parameter(Mandatory=$true)]
    [string]$AdminPassword
)

if ($AdminUsername -notmatch '^[a-z0-9][a-z0-9]*$') {
    Write-Error "AdminUsername must contain only lowercase letters and numbers, and cannot start with a special character."
    exit 1
}

$ResourceGroup = "vm-sqltest-rg"
$Location = "chinanorth3"
$VMName = "sqltest-client"
$VMSize = "Standard_D4s_v3"

Write-Host "Switching to Azure China cloud..."
az cloud set --name AzureChinaCloud
az login

Write-Host "Creating resource group $ResourceGroup ..."
az group create --name $ResourceGroup --location $Location

Write-Host "Creating Ubuntu 22 VM..."
$vmCreate = az vm create `
    --resource-group $ResourceGroup `
    --name $VMName `
    --image "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest" `
    --size $VMSize `
    --admin-username $AdminUsername `
    --admin-password $AdminPassword `
    --location $Location `
    --public-ip-sku Standard `
    --only-show-errors `
    --output json | ConvertFrom-Json

if (-not $vmCreate.id) {
    Write-Error "VM creation failed. Please check previous error messages."
    exit 1
}

