#!/usr/local/bin/python
# -*- coding: utf-8 -*-
import glob
import json

questions_dir = "questions"

for file in glob.glob(questions_dir + "/*.json"):
	with open(file) as f:
		step = file.replace("questions/", "").replace('.json', '')
		question = json.load(f)
		for q in question[u'questions']:
			#print '{}.{} = "{}";'.format(step , q[u'id'] , q['text'])
			row=step+'.'+q[u'id']+' = "'+q['text']+'";'
			if not q['text'] == "":
				print row