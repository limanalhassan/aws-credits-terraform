def handler(event, context):
    name = (event.get("queryStringParameters") or {}).get("name", "world")
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "text/html; charset=utf-8"},
        "body": f"<h1>Hello, {name}</h1><p>Served by AWS Lambda.</p>",
    }
