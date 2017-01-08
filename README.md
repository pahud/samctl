# samctl
a handy controller script over [AWS SAM(AWS Serverless Application Model)](https://aws.amazon.com/tw/about-aws/whats-new/2016/11/introducing-the-aws-serverless-application-model/)

# Usage

### package the bundle

```
$ bash samctl.sh -a package -f <template_file> -s <stack_name>
```

**template_file**:  default is ***template.yaml*** if not specified

**stack_name**: default is ***serverless-stack*** if not specified



### deploy the bundle

```
$ bash samctl.sh -a deploy -f <template_file> -s <stack_name>
```



### delete the bundle

```
$ bash samctl.sh -a DELETE -f <template_file> -s <stack_name>
```



## Handy shortcuts

```
-ap : -a package
-ad : -a deploy
-aD : -a DELETE
```

e.g.

```
// publish the bundle and then deploy it
$ bash samctl.sh -ap && bash samctl.sh -ad  
```



## Further Reading

Deploying Lambda-based Applications - AWS Lambda - http://docs.aws.amazon.com/lambda/latest/dg/deploying-lambda-apps.html

awslabs/serverless-application-model: AWS Serverless Application Model (AWS SAM) prescribes rules for expressing Serverless applications on AWS. - https://github.com/awslabs/serverless-application-model