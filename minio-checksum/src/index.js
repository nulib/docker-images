#!/usr/bin/env node

const AWS = require('aws-sdk');
if (process.env["AWS_S3_ENDPOINT"]) {
  AWS.config.s3 = {
    endpoint: process.env["AWS_S3_ENDPOINT"],
    s3ForcePathStyle: true,
  };
}

const crypto = require('crypto');

const generateDigest = (bucket, key) => {
  console.log(`Digesting s3://${bucket}/${key}`);
  return new Promise((resolve, reject) => {
    let md5 = crypto.createHash("md5");
    let sha1 = crypto.createHash("sha1");

    let s3Stream = new AWS.S3()
      .getObject({ Bucket: bucket, Key: key })
      .createReadStream();

    s3Stream
      .on("data", (chunk) => {
        md5.update(chunk);
        sha1.update(chunk);
      })
      .on("end", () =>
        resolve({ md5: md5.digest("hex"), sha1: sha1.digest("hex") })
      )
      .on("error", (err) => reject(err));
  });
};

const tagObject = async (bucket, key, digests) => {
  console.log(`Tagging s3://${bucket}/${key}`);

  const timestamp = Number(new Date()).toString();
  let tagSet = [];
  for (hash in digests) {
    tagSet.push({ Key: `computed-${hash}`, Value: digests[hash] });
    tagSet.push({ Key: `computed-${hash}-last-modified`, Value: timestamp });
  }

  const params = { Bucket: bucket, Key: key, Tagging: { TagSet: tagSet } };
  return await new AWS.S3().putObjectTagging(params).promise();
};

const server = require('diet');
const app = server();
app.listen('http://0.0.0.0:8000');

app.post('/fixity', ($) => {
  if ($.body.EventName === 's3:ObjectCreated:PutTagging') {
    $.status(204, "No Content");
    $.end();
  } else {
    const record = $.body.Records[0];
    const bucket = decodeURIComponent(record.s3.bucket.name);
    const key = decodeURIComponent(record.s3.object.key);
    generateDigest(bucket, key)
    .then((digests) => {
      tagObject(bucket, key, digests)
      .then(() => $.end());
    });
  }
});