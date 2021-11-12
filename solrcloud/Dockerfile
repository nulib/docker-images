FROM solr:7.5-alpine
CMD [ "solr", "-f", "-cloud" ]
HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=3 CMD [ "echo", "stat", "|", "nc", "localhost", "9983" ]