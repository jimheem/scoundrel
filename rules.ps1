$adgu=get-aduser -filter * -properties emailaddress
foreach ($adu in $adgu) {

$user=$adu.emailaddress
$rules=get-inboxrule -mailbox $user

foreach ($rule in $rules) {
	if ($rule.forwardto) {
	$found = $user + "," + $rule.name + "," + $rule.forwardto
	write-host $user
	echo $found >> rules.csv
	}
	$found=""
}
}
