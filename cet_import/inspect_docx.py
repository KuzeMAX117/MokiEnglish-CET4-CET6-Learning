# -*- coding: utf-8 -*-
from docx import Document

doc = Document("sample_2023_cet4_1.docx")
for i, para in enumerate(doc.paragraphs):
    text = para.text.strip()
    if text:
        print(f"[{i:03d}] {text[:200]}")
    if i > 150:
        break
