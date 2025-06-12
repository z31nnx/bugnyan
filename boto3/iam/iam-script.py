from datetime import datetime, timedelta, timezone
import boto3
iam = boto3.client("iam")
now = datetime.now(timezone.utc)
calc = now - timedelta(milliseconds=90)
confirm = input(f"Scan? yes/no: ")

if confirm.lower() != "yes":
    print(f"Killed")
    exit()
    
response = iam.list_users()
for user in response["Users"]:
    username = user.get("UserName")
    createdate = user.get("CreateDate", "N/A")
    password_last_used = user.get("PasswordLastUsed")
    print(f"User: {username}")
    
    mfa = iam.list_mfa_devices(UserName=username)
    if not mfa["MFADevices"]:
        print(f"MFA: has no MFA")
    else:
        (f"MFA: Enabled")
     
    keys = iam.list_access_keys(UserName=username)
    if not keys["AccessKeyMetadata"]:
        print(f"AccessKeyId: none")
    else:
        for key in keys["AccessKeyMetadata"]:
            access_key_id = key.get("AccessKeyId", "N/A")
            print(f"AccessKeyId: {access_key_id}")
            
    print(f"-" * 40)
    
print(f"Scan complete")