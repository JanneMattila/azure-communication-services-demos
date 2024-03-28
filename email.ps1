$acsName = "acs000000010"

$clienId = "<Entra Application ID>"
$clientSecret = "<Entra Application Secret>"
$tenantId = "<Entra Tenant ID>"

$from = "<Your app>@contoso.com"
$to = "<Your email>@contoso.com"

$username = "$acsName|$clienId|$tenantId"

$password = ConvertTo-SecureString -String $clientSecret -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

$subject = "Example email from PowerShell script"
$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>$subject</title>
</head>
<body>
    <h1>$subject</h1>
    <p>This is a test email.</p>
    <p>Go to <a href="https://portal.azure.com">Azure Portal</a> for more information.</p>
</body>
</html>
"@

Send-MailMessage `
    -To $to `
    -From $from `
    -Subject $subject `
    -BodyAsHtml $html `
    -Credential $credential `
    -SmtpServer "smtp.azurecomm.net" `
    -UseSsl `
    -Port 587
