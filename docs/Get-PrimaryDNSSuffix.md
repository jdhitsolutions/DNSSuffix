---
external help file: DNSSuffix-help.xml
Module Name: DNSSuffix
online version:
schema: 2.0.0
---

# Get-PrimaryDNSSuffix

## SYNOPSIS
Get Primary DNS suffix settings

## SYNTAX

```
Get-PrimaryDNSSuffix [[-Computername] <String[]>] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
This command will query the registry to display settings for the primary DNS suffix setting that you see when setting the computer name under system properties. This command relies on PowerShell remoting to query the remote registry.

## EXAMPLES

### --------------------------- Example 1 --------------------------- 
```powershell
PS C:\>Get-PrimaryDNSSuffix


Computername : Bovine320
Domain       : globomantics.local
NV Domain    : globomantics.local
```

Get the DNS settings for the local computer.

### --------------------------- Example 2 --------------------------- 
```powershell
PS C:\>Get-PrimaryDNSSuffix -computername srv1,srv2


Computername : SRV1
Domain       : company.local
NV Domain    : company.local

Computername : SRV2
Domain       : company.local
NV Domain    : company.local
```

Get the DNS settings for remote computers.
## PARAMETERS

### -Computername
The names of one or more computers to query. When querying the local computer you must be running in an elevated session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: $env:computername
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential
Specify an optional credential for remote computers.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]


## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/
## RELATED LINKS
[Set-PrimaryDNSSuffix]()