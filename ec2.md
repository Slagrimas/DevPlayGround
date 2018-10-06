$ aws ec2 create-security-group --group-name devenv-sg --description "security group for development environment"

need to save this:
```json
{
    "GroupId": "sg-#########"
}
```

$ aws ec2 authorize-security-group-ingress --group-name devenv-sg --protocol tcp --port 22 --cidr 0.0.0.0/0


$ aws ec2 create-key-pair --key-name devenv-key --query 'KeyMaterial' --output text > devenv-key.pem

# saves .pem file in current directory

$ chmod 400 devenv-key.pem

# have to use $groupid variable sg-<groupid>
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-0f65671a86f061fcd
# Free Tier

$ aws ec2 run-instances --image-id ami-0f65671a86f061fcd --security-group-ids sg-06154d2f66e888ccb --count 1 --instance-type t2.micro --key-name devenv-key --query 'Instances[0].InstanceId'

# region affect ami-#####
# response
# i-0b43492678d53b7b9

# use instance id as variable $instanceid
# have to use a sleep method to wait for instance to start before this query


$ aws ec2 describe-instances --instance-ids i-0b43492678d53b7b9 --query 'Reservations[0].Instances[0].PublicIpAddress'

#ip as variable $instanceip
# "18.224.94.239"

ssh -i devenv-key.pem ubuntu@18.224.##.###

# entered into ip as ubuntu

username=$1

sudo adduser $username
sudo mkdir /home/$username/.ssh
sudo bash -c "echo '$id_rsa.pub' > /home/$username/.ssh/authorized_keys"

# user has to input their own password and bio info

$ exit

$ ssh $username@$instanceip

if success - end of script





