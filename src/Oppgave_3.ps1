$url = "http://nav-deckofcards.herokuapp.com/shuffle"
$response = Invoke-WebRequest -Uri $url
$cards = $response.Content | ConvertFrom-Json

$kortstokk = @()
ForEach ($card in $cards) {
    $kortstokk += ($card.suit[0] + $card.value)
}
Write-Host "Kortstokk : $Kortstokk"