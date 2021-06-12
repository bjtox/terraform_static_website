# terraform_static_website
this is a simple Terraform template create a static website with a cloudfront distribution in front of him.

## Compatibility
terraform version >= 0.13

## Requirements

### Policy
policy must be create and attacched to a user or a role

``` json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudfront:*",
                "s3:ListAllMyBuckets",
                "s3:HeadBucket",
                "acm:GetCertificate",
                "acm:ListCertificates",
                "acm:ExportCertificate",
                "acm:ListTagsForCertificate",
                "acm:DescribeCertificate",
                "acm:RequestCertificate",
                "acm:AddTagsToCertificate",
                "acm:DeleteCertificate"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::<bucket-prefix>-*",
                "arn:aws:s3:::<bucket-prefix>-*/*"
            ]
        }
    ]
}
```

### Vars
you need to specify some vars in a tfvars file
```terraform
bucket_name_prefix = "my-bucket-name-prefix"
#name are calculated adding account id in bucket name like "my-bucket-name-prefix-123456789123"
dist_aliases = ["site.com", "www.site.com"]
aws_region = "eu-west-1"
```