#By Fernando Cruz - fernandos.cruzz@gmail.com
#testa conectividade
Test-NetConnection -Port 587 -ComputerName email-smtp.us-west-2.amazonaws.com


#cria função para enviar email
function SendEmail($Server, $Port, $Sender, $Recipient, $Subject, $Body) {
    $Username = "XXXXXXXXXXXXXXXXXX"
    $pwdTxt = Get-Content "C:\tmp\Password.txt"
    $Password = $(ConvertTo-SecureString -AsPlainText -String $pwdTxt -Force)
    $Credentials = [Net.NetworkCredential]
  
    $SMTPClient = New-Object Net.Mail.SmtpClient($Server, $Port)
    $SMTPClient.EnableSsl = $true
    
    $SMTPClient.Credentials = $(New-Object System.Management.Automation.PSCredential ($Username, $Password));
    try {
        Write-Output "Sending message..."
        $SMTPClient.Send($Sender, $Recipient, $Subject, $Body)
        Write-Output "Message successfully sent to $($Recipient)"
    } catch [System.Exception] {
        Write-Output "An error occurred:"
        Write-Error $_
    }
}

#configurações
function SendTestEmail(){
    $Server = "email-smtp.us-east-1.amazonaws.com"
    $Port = 587

    $Subject = "Test email sent from Amazon SES"
    $Body = "This message was sent from Amazon SES using PowerShell (explicit SSL, port 587)."

    $Sender = "test@youdomain.com.br"
    $Recipient = "youmail@gmail.com"

    SendEmail $Server $Port $Sender $Recipient $Subject $Body
}



#enviando vários e-mails testes

$i=1

while ($i -le 5) {

    SendTestEmail 
    $i
    $i++
    
    }
    











