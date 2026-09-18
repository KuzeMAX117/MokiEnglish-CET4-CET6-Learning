# -*- coding: utf-8 -*-
"""Inspect all sample docx files"""
from docx import Document
import os

for i in range(1, 7):
    fname = f"sample_{i}.docx"
    if not os.path.exists(fname):
        continue
    print(f"\n{'='*80}")
    print(f"FILE: {fname}")
    print(f"{'='*80}")
    doc = Document(fname)
    for j, para in enumerate(doc.paragraphs):
        text = para.text.strip()
        if text:
            print(f"[{j:03d}] {text[:250]}")
        if j > 80:
            print("... (truncated)")
            break
