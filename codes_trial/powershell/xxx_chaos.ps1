# this is a single line comment

<#
    this
    is
    a
    multi
    line
    comment
#>

$something = 'Hello World'
Write-Output $something
$something = 123
Write-Output $something
$something = $true
Write-Output $something
$something = $null
Write-Output $something
$something = @(1, 2, 3)
Write-Output $something
$something = @{
    foo = "bar"
}
Write-Output $something

function Get-ModifiedIndentLevel {
    $indentLevel = 0

    function Change-IndentLevel {
        $script:indentLevel += 1
        if ($script:indentLevel -lt 5) {
            Change-IndentLevel
        }
        return $script:indentLevel
    }

    # Use a scoped variable so Change-IndentLevel can modify it
    $script:indentLevel = $indentLevel
    $result = Change-IndentLevel
    Remove-Variable indentLevel -Scope Script -ErrorAction SilentlyContinue
    return $result
}

Write-Output "Get-ModifiedIndentLevel(): $(Get-ModifiedIndentLevel)"

function New-Multiplier {
    param ($x)
    return {
        param ($y)
        return $x * $y
    }.GetNewClosure()
}

$mult10 = New-Multiplier 10
Write-Output (& $mult10 5)
