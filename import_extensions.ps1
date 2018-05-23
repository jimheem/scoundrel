$users=import-csv S:\extensions.csv

foreach ($user in $users) {
	get-aduser $user.username | set-aduser -replace @{telephonenumber=$user.ipphone}

}
