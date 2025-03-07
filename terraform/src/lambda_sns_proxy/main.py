import json
import os
import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    topic_number = event.get('topic')
    username = event.get('username')
    if topic_number and username:
        sns_topic_prefix = os.environ.get('SNS_TOPIC_PREFIX')
        sns_topic_arn = os.environ.get(f'{sns_topic_prefix}-topic-{topic_number}-{username}')
        sns_client = boto3.client('sns')
        try:
            if isinstance(event, str):
                try:
                    message = json.loads(event)
                except json.JSONDecodeError:
                    message = event
            else:
                message = event
            response = sns_client.publish(
                TopicArn=sns_topic_arn,
                Message=json.dumps(message),
                MessageStructure='string'
            )
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': 'Message published',
                    'messageId': response['MessageId']
                })
            }
        except ClientError as e:
            return {
                'statusCode': 500,
                'body': json.dumps({
                    'error': f'Error: {str(e)}'
                })
            }
    else:
        return {
            'statusCode': 404,
            'body': json.dumps({
                'error': 'Invalid path parameters'
            })
        }

