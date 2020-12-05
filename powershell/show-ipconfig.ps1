Get-CimInstance win32_networkadapterconfiguration |
	Where-Object {$_.ipenabled -eq "True"} |
	Format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder