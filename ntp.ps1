Clear-Host

Write-Host " "
Write-Host "Dev by Fastiraz"
Write-Host " "
Write-Host " "

$rdp = Read-Host -Prompt '[E]nable/[D]isable/[S]kip NTP Server ? [E|D|S]'

if ( $rdp.Contains("e") -Or $rdp.Contains("E") )
{
    try 
    {
        <# enable NTP Server #>
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer' -name "Enabled" -value 1
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config' -name "AnnounceFlags" -value 5
        Restart-Service w32time

        <# setup firewall #>
        #Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    }
    catch {
        {1:<#Do this if a terminating exception happens#>}
    }
}

elseif ( $rdp.Contains("d") -Or $rdp.Contains("D") ) 
{
    try {
        <# disable NTP Server #>
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer' -name "Enabled" -value 0
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config' -name "AnnounceFlags" -value 0x61
        Restart-Service w32time
    }
    catch {
        {1:<#Do this if a terminating exception happens#>}
    }
}

elseif ( $rdp.Contains("s") -Or $rdp.Contains("S") ) 
{
    break
}

else {
    <# Action when all if and elseif conditions are false #>
    Write-Host "Select a valid value."
}