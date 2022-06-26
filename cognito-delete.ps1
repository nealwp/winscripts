param (
    [string]$email
)

$AWS_USER_POOL_ID = 'us-west-2_q11fv3vVZ'

$cognito_user = aws cognito-idp admin-get-user `
    --profile proven-dev `
    --user-pool-id $AWS_USER_POOL_ID `
    --username $email

$username = ($cognito_user | ConvertFrom-Json).Username

aws cognito-idp admin-delete-user `
    --profile proven-dev `
    --user-pool-id $AWS_USER_POOL_ID `
    --username $username

