<#
.SYNOPSIS
    convert a base64 string to a byte file

.DESCRIPTION
    This file converts the provided base64 string to a byte file.

.PARAMETER pathSrc
    The file to convert from.

.PARAMETER pathTgt
    The path\file to save byte output to, from pathSrc.

.EXAMPLE
    .\b64-2v2.ps1 'C:\Collections.7z.b64' 'C:\Collections.7z'

.NOTES
    Author: Jimmi Aylesworth
    Last Edit: 2022-04-25
    Version 1.0 - file creation
#>

Param([String]$pathSrc, [String]$pathTgt)
$encoding = [System.Text.Encoding]::ASCII

$B64String = [System.IO.File]::ReadAllText($pathSrc, $encoding)
Write-Host "Tgt file size: $([Math]::Round($B64String.Length / 1Mb,2)) MiB"
$swDecode = [System.Diagnostics.Stopwatch]::StartNew()
$bytes = [System.Convert]::FromBase64String($B64String)
$swDecode.Stop()
[System.IO.File]::WriteAllBytes($pathTgt, $bytes)

Write-Host "Decoding time: $([Math]::Round($swDecode.Elapsed.TotalSeconds,3)) s"
