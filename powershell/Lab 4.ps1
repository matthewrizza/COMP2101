# Question 1: This function gets the system hardware description.
# Finished.
function Get-HWInfo {
    Get-WmiObject win32_computersystem | Format-List
}


# Question 2: This function gets the name and version number of the operating system.
# Finished.
function Get-SysInfo {
    $os = Get-WmiObject win32_operatingsystem
    $sysInfo = foreach ($device in $os) {
                    New-Object psobject -Property @{
                        Name = $device.Name
                        Version = $device.Version
                }
            }
    $sysInfo | Format-List Name, Version
}


# Question 3: This function gets different processor components including, speed, number of cores, and the sizes of L1, L2, and L3 cache.
# Finished.
function Get-ProcessorInfo {
    Get-WmiObject win32_processor |
        Select-Object MaxClockSpeed,
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
Get-ProcessorInfo

# Question 4: This function shows a summary of the your RAM components.
# Needs completing: Size & Bank Slot for each DIMM. Total RAM.
function Get-RAM {
    $ramComponents = Get-WmiObject win32_physicalmemory
    $ramInfo =  foreach ($ram in $ramComponents) {
                    New-Object psobject -Property @{
                        Vendor = $ram.Manufacturer 
                        Description = $ram.Description
                        Size = $ram.Capacity
                }
            }
    $ramInfo | Format-List Vendor, Description, Size
}


# Question 5: This function gets a summary of the physical disk drives.
# Needs completing: Everything.
function Get-Summary {
    $diskdrives = Get-WmiObject win32_diskdrive
    $summaryInfo = foreach ( $disk in $diskdrives) {
                        $partitions = Get-WmiObject win32_diskpartition
                        foreach ( $partition in $partitions ) {
                               $logicaldisks = Get-WmiObject win32_logicaldisk
                               foreach ( $logicaldisk in $logicaldisks ) {
                            }
                    }
                }
}


# Question 6: This function gets your network adapter configuration report
# Finished.
function Get-IPConfig {
    Get-CimInstance win32_networkadapterconfiguration |
	    Where-Object {$_.ipenabled -eq "True"} |
	    Format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder
}


# Question 7: This function gets the vendor, description, and current screen resolution of the video card.
# Finished.
function Get-VideoCard {
    $videoCards = Get-WmiObject win32_videocontroller
    $videoCardInfo = foreach ( $videoCard in $videoCards ) {
                            New-Object psobject -Property @{
                                Vendor = $videoCard.Name
                                Description = $videoCard.Description
                                "Screen Resolution" = [string]$videoCard.CurrentHorizontalResolution + " x " + [string]$videoCard.CurrentVerticalResolution
                        }
                }
    $videoCardInfo | Format-List Vendor, Description, "Screen Resolution"           
}

