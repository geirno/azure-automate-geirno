[CmdletBinding()]
Param (
    [Parameter()]
    [String]
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)
$ErrorActionPreference = 'Stop'

$response = Invoke-WebRequest -Uri $UrlKortstokk
$cards = $response.Content | ConvertFrom-Json

$sum = 0
ForEach ($card in $cards) {
    $sum += switch ($card.value) {
        'J' { 10 }
        'Q' { 10 }
        'K' { 10 }
        'A' { 11 }
        Default {$card.value}
    }
}
$kortstokk = @()
ForEach ($card in $cards) {
    $kortstokk += ($card.suit[0] + $card.value)
}
Write-Host "Kortstokk : $Kortstokk" 
Write-host "Poengsum: $sum"