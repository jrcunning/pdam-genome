from robobrowser import RoboBrowser
import re
import sys

f=open(sys.argv[1])
goterms=f.read()
goterms2 = '\n'+goterms

br = RoboBrowser(parser="lxml")
br.open("http://revigo.irb.hr/")

form = br.get_form()
form["goList"].value = goterms2
form["cutoff"].value = '0.50'
form["isPValue"].value = 'no'
form["whatIsBetter"].value = 'higher'
form["goSizes"].value = '0'
form["measure"].value = 'SIMREL'

br.submit_form(form)

#download_rsc_link = br.find("a", href=re.compile("toR.jsp"))
#br.follow_link(download_rsc_link)
#r_code = br.response.content.decode("utf-8")
#r_script = open(sys.argv[2], "a")
#r_script.write(r_code)
#r_script.close()

#br.back()

download_csv_link = br.find("a", href=re.compile("export.jsp"))
br.follow_link(download_csv_link)
csv_content = br.response.content.decode("utf-8")
data = open(sys.argv[2], "a")
data.write(csv_content)
data.close()
