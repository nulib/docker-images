FROM        mogadanez/sqsd
MAINTAINER  Michael B. Klein <michael.klein@northwestern.edu>
COPY        wait-for-sqs.sh .
CMD         ["./wait-for-sqs.sh", "node", "run-cli.js", "--user-agent", "aws-sqsd"]
HEALTHCHECK --interval=30s --timeout=5s CMD ps 1 | grep run-cli.js
