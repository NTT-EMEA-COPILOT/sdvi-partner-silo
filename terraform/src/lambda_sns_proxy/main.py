import json
import os
from pyexpat.errors import messages

import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    print(f"event: {event}")
    body = json.loads(event.get('body','{}'))
    topic_number = body.get('topic')
    username = body.get('username')
    message = json.loads(body.get('message', '{}'))
    if topic_number and username:
        sns_topic_prefix = os.environ.get('SNS_TOPIC_PREFIX')
        sns_topic_arn = f'{sns_topic_prefix}-topic-{topic_number}-{username}'
        print(f"topic_arn: {sns_topic_arn}")
        print(f"payload: {json.dumps(message)}")
        sns_client = boto3.client('sns')
        try:
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

