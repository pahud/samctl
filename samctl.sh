#!/bin/bash
#
# samctl.sh - a tiny SAM control script created by Pahud
# 

OPTIND=1    
# Initialize our own variables:
output_file=""
verbose=0
default_s3_bucket='pahud-lambda-tmp'


show_help() {
    echo "Usage: samctl.sh -a <action> -f <template_file> -s <stack_name> -S <s3_bucket>"
    echo "<action>: package|deploy|DELETE|p|d|D"
}

while getopts "h?a:s:f:S:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    s)  stack_name=$OPTARG
        ;;
    a)  action=$OPTARG
        ;;
    f)  template_file=$OPTARG
        ;;
    S)  s3bucket=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

region=${region-ap-northeast-1}
stack_name=${stack_name-serverless-stack}
template_file=${template_file-template.yaml}
template_output_file="${template_file%%.yaml}-output.yaml"
aws_profile=${aws_profile-default}
s3bucket=${s3bucket-$default_s3_bucket}


package() {
	echo "[INFO] start packaging"
	aws --profile=$aws_profile --region="$region" \
	cloudformation package \
	   --template-file "$template_file" \
	   --output-template-file "$template_output_file" \
	   --s3-bucket $s3bucket
}

deploy() {
	echo "[INFO] start deploying"
	aws --profile=$aws_profile --region=$region \
	cloudformation deploy \
		--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
		--template-file "$PWD/$template_output_file" --stack-name $stack_name
}

delete() {
	echo "[INFO] start deleting stack: $stack_name"
	aws --profile=$aws_profile --region=$region \
	cloudformation delete-stack --stack-name $stack_name
}


case $action in 
	package|p) 
		package && \
		echo "[DONE] run \"bash samctl.sh -a deploy -f $template_file\" to start deploy"
	;;
	deploy|d) 
		deploy
	;;
	DELETE|D) 
		delete
	;;	
	*)
		show_help
		exit 1
esac


exit 0


