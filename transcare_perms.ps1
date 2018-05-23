PARAM (
   [string]$path
   )
   ##needs NTFSSecurity Module https://gallery.technet.microsoft.com/scriptcenter/1abd77a5-9c0b-4a2b-acef-90dbb2b84e85
   Import-Module NTFSSecurity

foreach ($file in (Get-ChildItem $path)) {
	if ($file.PSIsContainer -eq $true) {
	Add-NTFSAccess $($file.fullname) -AccessRights Delete -Appliesto ThisFolderOnly -accesstype Deny -account everyone
	get-ntfsaccess $($file.fullname)
	}
}

