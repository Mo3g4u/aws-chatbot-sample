import json

def lambda_handler(event, context):
    print("Error: xxxxxxxxx")

    return {
        'statusCode': 200,
        'body': json.dumps('Chatbot sample lambda function!')
    }
