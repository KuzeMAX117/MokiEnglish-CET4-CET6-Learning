# -*- coding: utf-8 -*-
import requests
import urllib3
import base64
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# First get the SHA of the file from tree API
tree_url = "https://api.github.com/repos/DieDiDi/CET4-6-past-exam-paper/git/trees/main?recursive=1"
r = requests.get(tree_url, verify=False, timeout=30)
data = r.json()

# Find all docx files
docx_files = [t for t in data['tree'] if t['path'].endswith('.docx') and t['type'] == 'blob']
print(f"Found {len(docx_files)} docx files")

# Download first file using blob API (base64 decode)
if docx_files:
    first = docx_files[0]
    print(f"Trying: {first['path']}")
    blob_url = first['url']
    r2 = requests.get(blob_url, verify=False, timeout=30)
    if r2.status_code == 200:
        blob_data = r2.json()
        content = base64.b64decode(blob_data['content'])
        with open("sample_2023_cet4_1.docx", "wb") as f:
            f.write(content)
        print(f"Downloaded: {len(content)} bytes")
    else:
        print(f"Blob API failed: {r2.status_code} {r2.text[:200]}")
