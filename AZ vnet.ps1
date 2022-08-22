$rg = @{
    Name = 'RG1'
    Location = 'EastUS'
}
New-AzResourceGroup @rg

$vnet = @{
    Name = 'Vnet1'
    ResourceGroupName = 'RG1'
    Location = 'EastUS'
    AddressPrefix = '192.168.10.0/24'   
}

$virtualNetwork = New-AzVirtualNetwork @vnet

$subnet = @{
    Name = 'subnet1'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '192.168.10.0/26'
}

$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet

$subnet = @{
    Name = 'subnet2'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '192.168.10.64/26'
}

$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet

$virtualNetwork | Set-AzVirtualNetwork

 
New-AzVm `
-ResourceGroupName "RG1" `
-Name "VM1" `
-Location "EastUS" `
-VirtualNetworkName "Vnet1" `
-SubnetName "subnet1" `
-PublicIpAddressName "vm1PubAdd" `
-OpenPorts 3389 `
-Image "Win2012R2Datacenter" `
-Size "Standard_DS1_v2"


New-AzVm `
-ResourceGroupName "RG1" `
-Name "VM2" `
-Location "EastUS" `
-VirtualNetworkName "Vnet1" `
-SubnetName "subnet2" `
-PublicIpAddressName "vm2PubIPAdd" `
-OpenPorts 3389,443 `
-Image "Win2012R2Datacenter" `
-Size "Standard_DS1_v2"


Get-AzVirtualNetwork
Get-Azvm

