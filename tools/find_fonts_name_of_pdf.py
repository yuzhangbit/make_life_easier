#! /usr/bin python
# -*- coding: utf-8 -*-
"""
Find all fonts used in a PDF.
"""
from __future__ import print_function
import fitz                       # PyMuPDF

import os, sys
cmd_arguments = sys.argv
cmd_arguments.pop(0)

if len(cmd_arguments) == 1:
    print("Process the pdf file.")
    doc = fitz.open(cmd_arguments[0])
    print(cmd_arguments[0])
    print("page number:", len(doc))
    for i in xrange(len(doc)):
        #print("page:", i)
        fontlist = doc.getPageFontList(i)
        if fontlist:
            print("fonts used on page", i)
        for font in fontlist:
            print("xref=%s, gen=%s, type=%s, basefont=%s, name=%s" % (font[0], font[1], font[2], font[3], font[4]))
else:
    print("Please provide one pdf file name.")
