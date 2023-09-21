#!/usr/bin/env python

import sys
import interpreter

if '-y' in sys.argv:
    interpreter.auto_run = True

interpreter.model = "gpt-4-32k"
interpreter.chat()
