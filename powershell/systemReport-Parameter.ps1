param (
        [switch]$System,
        [switch]$Disks,
        [switch]$Network
)

if ( $System -eq $false -and $Disks -eq $false -and $Network -eq $false ) {
        systemReport.ps1
}
else {
        Write-Output ""
        Write-Output "System Information Report"
        Write-Output "--------------------------"
        Write-Output "
        "
        if ( $System -eq $true ) {
    
            Write-Output "Processor"
            Write-Output "----------------------"
            (Get-ProcessorInfo | Out-String).Trim()
            Write-Output "

            "    
            Write-Output "Operating System"
            Write-Output "----------------------"
            (Get-SysInfo | Out-String).Trim()
            Write-Output "
    
            "
            Write-Output "Memory"
            Write-Output "----------------------"
            (Get-RAM | Out-String).Trim()
            Write-Output "

            "
            Write-Output "Video Card"
            Write-Output "----------------------"
            (Get-VideoCard | Out-String).Trim()
            Write-Output ""
        }

        if ( $Disks -eq $true ) {
    
            Write-Output "Physical Disk Drives"
            Write-Output "----------------------"
            (Get-Summary | Out-String).Trim()
            Write-Output ""
        }

        if ( $Network -eq $true ) {

            Write-Output "Network Adapter"
            Write-Output "----------------------"
            (Get-IPConfig | Out-String).Trim()
            Write-Output ""
        }
}
