import smtplib
import traceback
USER="YOUR USERNAME GMAIL"
PASSWORD="YOUR PASSWD GMAIL"
FROM="YOUR GMAIL ADDRESS"
TO=['fake1@gmail.com', 'fake2@gmail.com']
SUBJECT="TEST TEST"
TEXT="Hello"
message="""\From: %s\nTo: %s\nSubject: %s\n\n%s
""" % (FROM, ", ".join(TO), SUBJECT, TEXT)
try:
    server = smtplib.SMTP("smtp.googlemail.com", 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(USER, PASSWORD)
    server.sendmail(FROM, TO, message)
    server.close()
    print 'successfully sent the mail'
except smtplib.SMTPException:
    print 'failed to send mail'
    traceback.print_exc()
