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

function kortstokkprint {
    param (
        [Parameter()]
        [Object[]]
        $cards
    )
    $kortstokk = @()
    ForEach ($card in $cards) {
        $kortstokk += ($card.suit[0] + $card.value)
    }
    $kortstokk  
}

Write-Host "Kortstokk : $(kortstokkprint($cards))" 
Write-host "Poengsum: $sum"

$meg = $cards[0..1]
$cards = $cards[2..$cards.Length]
$Magnus =  $cards[0..1]
$cards = $cards[2..$cards.Length]

Write-Host "Meg : $(kortstokkprint($meg))"
Write-Host "Magnus : $(kortstokkprint($magnus))"
Write-Host "Kortstokk : $(kortstokkprint($cards))"