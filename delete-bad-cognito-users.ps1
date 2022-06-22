$AWS_REGION = 'eu-west-2'
$AWS_USER_POOL_ID = 'eu-west-2_UbtlmoLkg'

$userList = aws cognito-idp list-users --region $AWS_REGION --user-pool-id $AWS_USER_POOL_ID | ConvertFrom-Json
$userList.Users | ForEach-Object {
    if ($_.UserStatus -like 'UNCONFIRMED'){
        aws cognito-idp admin-delete-user --region $AWS_REGION --user-pool-id $AWS_USER_POOL_ID --username $_.Username
    }  
}

