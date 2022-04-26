<#
.SYNOPSIS
    convert a byte file to base64 string

.DESCRIPTION
    This file converts a provided file to a base64 text file.

.PARAMETER pathSrc
    The file to convert from.

.PARAMETER pathTgt
    The path\file to save base64 text output to, from pathSrc.

.EXAMPLE
    .\2b64v2.ps1 'C:\Collections.7z' 'C:\Collections.7z.b64'

.NOTES
    Author: Jimmi Aylesworth
    Last Edit: 2022-04-25
    Version 1.0 - file creation
#>

Param([String]$pathSrc, [String]$pathTgt)
$encoding = [System.Text.Encoding]::ASCII

$bytes = [System.IO.File]::ReadAllBytes($pathSrc)
Write-Host "Src file size: $([Math]::Round($bytes.Count / 1Mb,2)) MiB"
$swEncode = [System.Diagnostics.Stopwatch]::StartNew()
$B64String = [System.Convert]::ToBase64String($bytes, [System.Base64FormattingOptions]::None)
$swEncode.Stop()
[System.IO.File]::WriteAllText($pathTgt, $B64String, $encoding)

Write-Host "Encoding time: $([Math]::Round($swEncode.Elapsed.TotalSeconds,3)) s"
