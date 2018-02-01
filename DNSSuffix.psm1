Function Set-PrimaryDNSSuffix {
    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(Position = 0, HelpMessage = "Enter the new primary DNS Suffix name e.g. company.pri")]
        [string]$DNSSuffix,
        [switch]$SynchronizeSuffix,
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:computername,
        [pscredential]$Credential
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Using a primary DNS Suffix of $DNSSuffix"
        if ($SynchronizeSuffix) {
            $synch = 1
        }
        else {
            $Synch = 0
        }
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Synchronize DNS with domain membership: $SynchronizeSuffix [$synch])]"
        #define the scriptblock to run on each computer
        $sb = {
            Param([string]$Value,[int]$Synch)
            Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $value
            Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Value
            Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name SyncDomainWithMembership -Value $Synch
        }
        #hashtable of parameters to splat to Invoke-Command
        $invoke = @{
            Scriptblock  = $sb
            ArgumentList = $DNSSuffix,$synch
            ErrorAction  = "Stop"
        }
        if ($Credential) {
            $invoke.add("Credential", $Credential)
        }
    } #begin
    
    Process {
        foreach ($computer in $computername) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Setting Primary DNS Suffix on $computer"
            $invoke.computername = $computer
            if ($PSCmdlet.ShouldProcess("$($DNSSuffix) on $computer")) {
                Try {
                    Invoke-Command @invoke
                }
                Catch {
                    Write-Warning "[$((Get-Date).TimeofDay) PROCESS] Error with command on $Computer. $($_.Exception.Message)"
                }
            }
        } #foreach
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end 

} #close Set-PrimaryDNSSuffix

Function Get-PrimaryDNSSuffix {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:computername,
        [pscredential]$Credential
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #define the scriptblock to run on each computer
        $sb = {
            $reg = Get-ItemProperty  HKLM:\system\CurrentControlSet\Services\tcpip\parameters 
            [pscustomobject]@{
                Computername = $reg.hostname
                Domain       = $reg.Domain
                'NV Domain'  = $reg.'NV Domain'
                SynchronizeSuffix = $reg.SyncDomainWithMembership -as [bool]
                
            }
        }
        #hashtable of parameters to splat to Invoke-Command
        $invoke = @{
            Scriptblock      = $sb
            ErrorAction      = "Stop"
            HideComputername = $True
        }
        if ($Credential) {
            $invoke.add("Credential", $Credential)
        }
    } #begin

    Process {
        
        foreach ($computer in $computername) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting Primary DNS Suffix settings from $computer."
            $invoke.computername = $computer

            Try {
                Invoke-Command @invoke | Select-object * -ExcludeProperty RunspaceID
            }
            Catch {
                write-warning "[$((Get-Date).TimeofDay) PROCESS] Error with command on $Computer. $($_.Exception.Message)"
            }
        } #foreach
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end 

} #close Get-PrimaryDNSSuffix