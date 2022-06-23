aws cognito-idp admin-set-user-password \
	--user-pool-id "us-west-2_q11fv3vVZ" \
	--username "demo.merchant@mail.com" \
	--password "DemoMerchant123!"

aws cognito-idp admin-update-user-attributes \
	--user-pool-id "us-west-2_q11fv3vVZ" \
	--username "demo.merchant@mail.com" \
	--user-attributes Name="email_verified",Value="true"

aws cognito-idp admin-confirm-sign-up \
	--user-pool-id "us-west-2_q11fv3vVZ" \
	--username "demo.merchant@mail.com" 
	
	
	
	r#.AU8fSaTd&ZAz