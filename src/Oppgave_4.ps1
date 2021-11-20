[CmdletBinding()]
Param (
    [Parameter()]
    [String]
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)
$ErrorActionPreference = 'Stop'

$response = Invoke-WebRequest -Uri $UrlKortstokk
$cards = $response.Content | ConvertFrom-Json

$kortstokk = @()
ForEach ($card in $cards) {
    $kortstokk += ($card.suit[0] + $card.value)
}
Write-Host "Kortstokk : $Kortstokk" 