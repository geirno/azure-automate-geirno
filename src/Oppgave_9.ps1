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

function kortstokksum {
    param (
        [Parameter()]
        [Object[]]
        $cards
    )
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
    $sum 
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
Write-host "Poengsum: $(kortstokksum($cards))"

$meg = $cards[0..1]
$cards = $cards[2..$cards.Length]
$Magnus =  $cards[0..1]
$cards = $cards[2..$cards.Length]

#Write-Host "Meg : $(kortstokkprint($meg))"
#Write-Host "Magnus : $(kortstokkprint($magnus))"
#Write-Host "Kortstokk : $(kortstokkprint($cards))"

# ...

function skrivUtResultat {
    param (
        [string]
        $vinner,        
        [object[]]
        $Magnus,
        [object[]]
        $Meg        
    )
    Write-Output "Vinner: $vinner"
    Write-Output "magnus | $(Kortstokkprint $Magnus) | $Magnsum"    
    Write-Output "meg    | $(Kortstokkprint $meg) | $Minsum"
    #Write-Host "Kortstokk : $(kortstokkprint($cards))"
}

$blackjack = 21
$minsum = $(kortstokksum $Meg)
$magnsum = $(kortstokksum $Magnus)


while ($minsum  -lt 17) {
    $meg += $cards[0]
    $cards = $cards[1..$cards.Length]
    $minsum = $(kortstokksum $Meg)
}
if ($minsum -gt $blackjack) {
    skrivUtResultat -vinner "Magnus"  $Magnus $meg
    exit
}
while ($magnsum -le $minsum) {
    $Magnus += $cards[0]
    $cards = $cards[1..$cards.Length]
    $magnsum = $(kortstokksum $Magnus)
    if ($magnsum -gt $blackjack) {
        skrivUtResultat -vinner "Meg"  $Magnus $meg
        exit
    }
}

if ($minsum -eq $blackjack -and $Magnsum -eq $blackjack) {
    Write-Host "Draw"
    exit
}
elseif ($minsum -eq $blackjack) {
    skrivUtResultat -vinner "Meg"  $Magnus $meg
    exit
}
elseif ($Magnsum -eq $blackjack) {
    skrivUtResultat -vinner "Magnus"  $Magnus $meg
    exit
}
elseif ($minsum -gt $Magnsum) {
    skrivUtResultat -vinner "Meg"  $Magnus $meg
    exit
}
elseif ($minsum -lt $Magnsum) {
    skrivUtResultat -vinner "Magnus"  $Magnus $meg
    exit
}
elseif ($minsum -eq $Magnsum) {
    skrivUtResultat -vinner "Uavgjort"  $Magnus $meg
    exit
}