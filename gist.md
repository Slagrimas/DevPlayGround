Prequisites: AWS Account
In AWS Console:
1. Go to IAM Service and create new group, name it `S3FullAccessGroup`, attach the `AmazonS3FullAccess` policy to it.
1. In IAM Service, add new user.  Name it something like `yourName_macbookpro_cli`.  Make sure only programmatic access is checked off. Add the user to the `S3FullAccessGroup`.
1. When done with wizard, it will give you your secret access key only ONCE.  Don't leave this page yet.



In Local Development Terminal:
1. OSX: `brew install awscli` Linux: `pip install awscli --upgrade --user`
2. `aws configure`
3. Enter Access Key Id
4. Enter Secret Access Key
5. Set default region to `us-west-2` (or whatever region you want the cli to default to)
Create new S3 bucket that's public, read only:
`aws s3api create-bucket --bucket my-bucket --acl public-read --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2`
Configure bucket to serve static website:
`aws s3 website s3://my-bucket/ --index-document index.html --error-document index.html`
Upload all files in current directory excluding .git folder and apply public-read permissions to all files:
`aws s3 sync . s3://my-bucket --delete --grants --acl public-read --exclude '.git*'`
Delete all files in bucket:
`aws s3 rm --recursive s3://my-bucket`
Delete entire bucket and contents:
`aws s3 rb s3://bucket-name --force`
Navigate to:
`http://my-bucket.s3-website-us-west-2.amazonaws.com