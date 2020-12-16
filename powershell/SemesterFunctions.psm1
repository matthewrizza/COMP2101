function Get-HWInfo {
    Get-WmiObject win32_computersystem | Format-List Name, Manufacturer, Model
}


function Get-SysInfo {
    $os = Get-WmiObject win32_operatingsystem
    $sysInfo = foreach ($device in $os) {
                    New-Object -TypeName psobject -Property @{
                        Name = $device.Caption
                        Version = $device.Version
                }
            }
    $sysInfo | Format-List Name, Version
}


function Get-ProcessorInfo {
    Get-WmiObject win32_processor |
        Select-Object Name,
                      CurrentClockSpeed,
                      NumberOfCores,
                      @{
                      n="L1 Cache Size";
                      e={
                            if ( $_.L1CacheSize -eq $null ) {
                                "Data Unavaiable"
                            }
                            else {
                                  $_.L1CacheSize
                            } 
                        }                     
                    },
                      @{
                      n="L2 Cache Size";
                      e={
                            if ( $_.L2CacheSize -eq $null ) {
                                "Data Unavaiable"
                            }
                            else {
                                  $_.L2CacheSize
                            } 
                        }                     
                    },
                      @{
                      n="L3 Cache Size";
                      e={
                            if ( $_.L3CacheSize -eq $null ) {
                                "Data Unavaiable"
                            }
                            else {
                                  $_.L3CacheSize
                            }                      
                        }
                    }
    Format-List MaxClockSpeed, NumberOfCores, "L1 Cache Size", "L2 Cache Size", "L3 Cache Size"
}


function Get-RAM {
    $ramComponents = Get-WmiObject win32_physicalmemory
    $ramInfo =  foreach ($ram in $ramComponents) {
                    New-Object -TypeName psobject -Property @{
                        Vendor = $ram.Manufacturer 
                        Description = $ram.Description
                        "Size(Mb)" = $ram.Capacity/1mb
                        Bank = $ram.BankLabel
                        Slot = $ram.DeviceLocator
                        "Total RAM(Mb)" = $ram.Capacity/1mb
                }               
            }
    $ramInfo | Format-Table Vendor, Description, "Size(Mb)", Bank, Slot, "Total RAM(Mb)"
}


function Get-Summary {
    $diskdrives = Get-CimInstance CIM_diskdrive
    $summaryInfo = foreach ( $disk in $diskdrives) {
                        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_diskpartition
                        foreach ( $partition in $partitions ) {
                               $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_logicaldisk
                               foreach ( $logicaldisk in $logicaldisks ) {
                                   New-Object -TypeName psobject -Property @{
                                        Vendor = $disk.Manufacturer
                                        Model = $disk.Model
                                        "Physical Disk Size(GB)" = $disk.Size/1gb -as [int]
                                        "Logical Disk Size(GB)" = $logicaldisk.Size/1gb -as [int]
                                        "Free Space(GB)" = $logicaldisk.FreeSpace/1gb -as [int]
                                        "Percentage Free(%)" = [math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)

                               }
                            }
                    }
                }
    $summaryInfo | Format-Table Vendor,Model,"Physical Disk Size(GB)","Logical Disk Size(GB)","Free Space(GB)","Percentage Free(%)"
}


function Get-IPConfig {
    Get-CimInstance win32_networkadapterconfiguration |
	    Where-Object {$_.ipenabled -eq "True"} |
	    Format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder
}


function Get-VideoCard {
    $videoCards = Get-WmiObject win32_videocontroller
    $videoCardInfo = foreach ( $videoCard in $videoCards ) {
                            New-Object -TypeName psobject -Property @{
                                Vendor = $videoCard.AdapterCompatibility
                                Description = $videoCard.Description
                                "Screen Resolution" = [string]$videoCard.CurrentHorizontalResolution + " x " + [string]$videoCard.CurrentVerticalResolution
                        }
                }
    $videoCardInfo | Format-List Vendor, Description, "Screen Resolution"           
}
