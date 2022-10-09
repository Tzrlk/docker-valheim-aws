# Docker Valheim Server: AWS Edition

This image adds a few small things to the [lloesche/valheim-server-docker][1] image:

* the `aws` cli client.
* hook scripts to do world storage in S3
  * load
  * save
  * backup
* a healthcheck script.

Obviously, all the aws functionality requires that some form of valid credentials are made available to the cli, so it can access the bucket you've given them read/write access to.

When running the image, setting `S3_URL_BAK` will cause backups to be saved there. Setting `S3_URL_CFG` will load it as the worlds file on startup, and save to it on exit. All the local file paths are determined from the existing lloesche settings.<br/>
It might be worth enabling bucket versioning if you're particularly paranoid about accidentally corrupting your worlds file, but you should be able to restore from backups in any event.

[1]: https://github.com/lloesche/valheim-server-docker
