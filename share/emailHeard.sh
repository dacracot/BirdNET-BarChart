#!/usr/bin/expect

# #!/bin/bash
# {
# WHEN=`date '+%Y-%m-%d--%H:%M'`
# echo "--------------"
# echo $WHEN
# echo "--------------"
#     RECIPIENTS="dacracot@yahoo.com"
#     MAILBODY="heard table content goes here"
#     SENDER="dacracot@gmail.com"
#     SUBJECT="Copy of HEARD from $HOSTNAME at "
#     echo -e "${MAILBODY}" | mailx -v -s "${SUBJECT} ${WHEN}" -r ${SENDER} ${RECIPIENTS}
# echo "=============="
# } >> emailHeard.out 2>> emailHeard.err
# 

set address "[lindex $argv 0]"
set subject "[lindex $argv 1]"
set ts_date "[lindex $argv 2]"
set ts_time "[lindex $argv 3]"

set timeout 10
spawn openssl s_client -connect smtp.gmail.com:465 -crlf -ign_eof 

expect "220" {
  send "EHLO localhost\n"

  expect "250" {
    send "AUTH LOGIN PLAIN AGRhY3JhY290QGdtYWlsLmNvbQJ3c3g3dWptQFdTWCZVSk0=\n"

    expect "235" {
      send "MAIL FROM: <dacracot@gmail.com>\n"

      expect "250" {
        send "RCPT TO: <$address>\n"

        expect "250" {
          send "DATA\n"

          expect "354" {
            send "Subject: $subject\n\n"
            send "Email sent on $ts_date at $ts_time.\n"
            send "\n.\n"

            expect "250" {
                send "quit\n"
            }
          }
        }
      }
    }
  }
}
