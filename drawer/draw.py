import json
import sys
import os
from urllib.request import Request, urlopen
from urllib.error import HTTPError

env_admin_sid = os.environ["ADMIN_SECRET_ID"]
env_host = os.getenv("API_HOST", "api.sakuten.jp")
env_protocol = os.getenv("API_PROTOCOL", "https")

def post_json(path, data=None, token=None):
    headers = {"Content-Type": "application/json"}
    if token:
        headers['Authorization'] = 'Bearer ' + token
    json_data = json.dumps(data).encode("utf-8") if data else None
    url = '{}://{}/{}'.format(env_protocol, env_host, path)
    request = Request(url, data=json_data,
                      headers=headers, method='POST')
    try:
        response = urlopen(request)
    except HTTPError as e:
        print('Error: {}'.format(e.read()), file=sys.stderr)
        sys.exit(-1)
    else:
        response_body = response.read().decode("utf-8")
        response.close()
        return json.loads(response_body)


# Login as admin
admin_cred = {
    'id': env_admin_sid,
    'g-recaptcha-response': ''
}

response = post_json('auth', admin_cred)
token = response['token']

# POST /draw_all
response_draw = post_json('draw_all', None, token)

# Print the result
print(response_draw)
