# -*- coding: utf-8 -*-
"""Download multiple sample docx files for analysis"""
import requests
import urllib3
import base64
import os
import time
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

tree_url = "https://api.github.com/repos/DieDiDi/CET4-6-past-exam-paper/git/trees/main?recursive=1"
r = requests.get(tree_url, verify=False, timeout=30)
data = r.json()

docx_files = [t for t in data['tree'] if t['path'].endswith('.docx') and t['type'] == 'blob']
print(f"Found {len(docx_files)} docx files")

# Download a few samples for analysis
samples_to_download = [
    # 2015 CET6
    docx_files[0],  # 2015 12月 六级卷一
    # 2016 CET4
    [f for f in docx_files if '2016' in f['path'] and '四级' in f['path']][0],
    # 2017 CET4  
    [f for f in docx_files if '2017' in f['path'] and '四级' in f['path']][0],
    # 2017 CET6
    [f for f in docx_files if '2017' in f['path'] and '六级' in f['path']][0],
    # 2023 CET4
    [f for f in docx_files if '2023' in f['path'] and '四级' in f['path']][0],
    # 2023 CET6
    [f for f in docx_files if '2023' in f['path'] and '六级' in f['path']][0],
]

for i, item in enumerate(samples_to_download):
    name = os.path.basename(item['path'])
    print(f"\n[{i+1}/{len(samples_to_download)}] Downloading: {item['path']}")
    blob_url = item['url']
    try:
        r2 = requests.get(blob_url, verify=False, timeout=30)
        if r2.status_code == 200:
            blob_data = r2.json()
            content = base64.b64decode(blob_data['content'])
            fname = f"sample_{i+1}.docx"
            with open(fname, "wb") as f:
                f.write(content)
            print(f"  Saved: {fname} ({len(content)} bytes)")
        else:
            print(f"  Failed: {r2.status_code}")
    except Exception as e:
        print(f"  Error: {e}")
    time.sleep(1)

print("\nDone!")
