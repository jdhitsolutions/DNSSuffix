---
external help file: DNSSuffix-help.xml
Module Name: DNSSuffix
online version:
schema: 2.0.0
---

# Set-PrimaryDNSSuffix

## SYNOPSIS
Set the primary DNS suffix

## SYNTAX

```
Set-PrimaryDNSSuffix [[-DNSSuffix] <String>] [-SynchronizeSuffix] [-Computername <String[]>]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This command will modify the registry to configure settings for the primary DNS suffix setting that you see when setting the computer name under system properties. This command relies on PowerShell remoting. When running it on the local computer you must run in an elevated PowerShell session. Nothing is written to the pipeline.

You shouldn't need to restart the computer after making these changes.

## EXAMPLES

###  ---------------------------------- Example 1 ---------------------------------- 
```powershell
PS C:\> Set-PrimaryDNSSuffix Company.pri -computername SRV1,SRV2
```

Modify the primary DNS suffix on remote computers to Company.pri. 

### ---------------------------------- Example 2 ---------------------------------- 
```powershell
PS C:\> Set-PrimaryDNSSuffix Company.com -synchronizeSuffix -computername SRV3 -credential company\administrator
```

Modify the primary DNS suffix on SRV3 and synchronize it with domain membership changes. This example also uses an alternate credential.
## PARAMETERS

### -DNSSuffix
Enter the new primary DNS Suffix name such as company.pri

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SynchronizeSuffix
This is the equivalent of checking or unchecking the box that says "Change primary DNS suffix when domain membership changes". Use this Switch to "check" the box. Omit it to "uncheck" the box.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Computername
The names of one or more computers to query. When configuring the local computer you must be running in an elevated session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $env:Computername
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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### None

## NOTES
Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PrimaryDNSSuffix]()