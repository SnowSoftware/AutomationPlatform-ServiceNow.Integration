function Get-ServiceNowAttachment {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$InstanceName,

        [Parameter(Mandatory=$True)]
        [PSCredential]$Credential,

        [Parameter(Mandatory=$True)]
        [ValidateSet('file_name','sys_tags','sys_id')]
        [string]$QueryParameter,

        [Parameter(Mandatory=$True)]
        [string]$QueryValue,

        [Parameter(Mandatory=$True)]
        [ValidateSet('=','LIKE')]
        [string]$QueryOperator,

        [Parameter()]
        [UInt32]$Limit = 1
    )

    begin {
        $KBQuery = "sysparm_query=$QueryParameter$QueryOperator$QueryValue"
        $KBLimit = "sysparm_limit=$Limit"

        $BaseUri  = "https://$InstanceName.service-now.com/api/now/"
        $Endpoint = 'attachment'

        [Uri]$Uri = "$BaseUri$Endpoint`?$KBLimit&$KBQuery"
        
        $KBInvokeSplat = @{
            'Uri' = $Uri
            'Method' = 'Get'
            'Credential' = $Credential
            'Headers'    = @{"accept"="application/json"}
        }
    }
    process {

    }
    end {
        $Result = Invoke-RestMethod @KBInvokeSplat
    
        $Out = $Result.result
    
        $Out
    }
}