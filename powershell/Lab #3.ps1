Get-CimInstance win32_networkadapterconfiguration |
	Where-Object ipenabled -eq True |
	Format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder