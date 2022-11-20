import hmac
import hashlib
import base64

host = "http://localhost"
query = "0x0/https://raw.githubusercontent.com/thumbor/thumbor/master/example.jpg"
key = "ALAMAKOTA"

b_message = bytes(query, 'UTF8')
b_key = bytes(key, 'UTF8')
digester = hmac.new(b_key, b_message, hashlib.sha1)
signature = digester.digest()

url_safe_sign = base64.urlsafe_b64encode(signature)
hash = url_safe_sign.decode("utf-8")

print('hash: %s' % hash)
print('address below')
print('%s/%s/%s' % (host, hash, query))
