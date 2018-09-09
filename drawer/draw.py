import json
import sys
from urllib.request import Request, urlopen
from urllib.error import HTTPError

env_list = os.environ["ID_LIST_FILE"]
env_host = os.getenv("API_HOST", "api.sakuten.jp")
env_protocol_ = os.getenv("API_PROTOCOL", "https")

with open(env_list, 'r') as f:
    id_list = json.load(f)

# Take one 'admin' user from list
admin_ids = next(cred for cred in id_list if cred['authority'] == 'admin')


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
    'id': admin_ids['secret_id'],
    'g-recaptcha-response': ''
}

response = post_json('auth', admin_cred)
token = response['token']

# POST /draw_all
response_draw = post_json('draw_all', None, token)

# Print the result
print(response_draw)
