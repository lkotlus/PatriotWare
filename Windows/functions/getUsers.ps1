function cut {
    param(
      [Parameter(ValueFromPipeline=$True)] [string]$inputobject,
      [string]$delimiter='\s+',
      [string[]]$field
    )
  
    process {
      if ($null -eq $field) { $inputobject -split $delimiter } else {
        ($inputobject -split $delimiter)[$field] }
    }
}
wmic useraccount get Name,Disabled | Select-String "FALSE.*" | cut -f 1 -d "     " > $args[0]