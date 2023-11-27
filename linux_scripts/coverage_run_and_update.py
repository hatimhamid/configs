# Copyright (C) 2023 VMware, Inc. All rights reserved.
# -- VMware Confidential
# Description: Script to update a web server html file to extract coverage
#              coverage details and add latest coverage info.
# Author     : Hatim Hamid <hhamid@vmware.com>
# Version    : 1.0.0

from bs4 import BeautifulSoup
import os
from datetime import datetime
import unicodedata

per_row_index = 13

#Read IKED coverage file
with open(os.environ["IKED_COV_FILE"]) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

#Extract IKED coverage percentage
row = soup.find(string="Lines:").parent.parent
iked_cov_percent = str(row.contents[per_row_index].string)
iked_cov_percent = float(iked_cov_percent.replace("%", "").rstrip())

#Read Quicksec coverage file
with open(os.environ["QUICKSEC_COV_FILE"]) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

#Extract Quicksec coverage percentage
row = soup.find(string="Lines:").parent.parent
quicksec_cov_percent = str(row.contents[per_row_index].string)
quicksec_cov_percent = float(quicksec_cov_percent.replace("%", "").rstrip())

#Read main index file
with open(os.environ["MAIN_HTML_FILE"]) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

#Focus on the intersting part
tbody = soup.body.center.table
#Get a new pre-existing tag to edit
with open(os.environ["NEW_TAG_FILE"]) as fp:
    new_tag = BeautifulSoup(fp, 'html.parser')

#Update Info
now = datetime.now()
col_num = 1
for row_data in new_tag.tr.contents:
    if col_num == 2:
        #get weekday
        row_data.string = now.strftime("%A")
    elif col_num == 4:
        row_data.string = now.strftime("%d-%b-%Y")
    elif col_num == 6:
        row_data.table.tr.td.contents[0]['width'] = int(iked_cov_percent)
        row_data.table.tr.td.contents[1]['width'] = 100 - int(iked_cov_percent)
    elif col_num == 8:
        row_data.a.string = str(iked_cov_percent) + " %"
        row_data.a['href'] = os.environ["IKED_REL"]
    elif col_num == 10:
        row_data.table.tr.td.contents[0]['width'] = int(quicksec_cov_percent)
        row_data.table.tr.td.contents[1]['width'] = 100 - int(quicksec_cov_percent)
    elif col_num == 12:
        row_data.a.string = str(quicksec_cov_percent) + " %"
        row_data.a['href'] = os.environ["QUICKSEC_REL"]
    elif col_num == 14:
        row_data.string = "Scheduled run on " + os.environ["BRANCH_NAME"] + " " + os.environ["BRANCH_VER"]
    col_num+=1

tbody.append(new_tag)

#Update file
with open(os.environ["MAIN_HTML_FILE"], "w") as file:
    file.write(unicodedata.normalize("NFKD", str(soup)))
