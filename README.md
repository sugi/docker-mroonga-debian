docker-mroonga-debian-wheezy
============================

Docker image of [Mroonga](http://mroonga.org/) on Debian wheezy.

How to run
----------

### Minimal way

    $ docker run --name mroonga -p 3306 sugi/mroonga

Then connect by root without password.

### Mmount data directories

mysql uses following path to save data.
You can mount volume to save data on outside container.

* /var/lib/mysql - MySQL Data and log directory
* /var/run/mysqld - Unix domain socket

e.g;

    $ docker run --name mroonga -p 3306 \
      -v /data/mroonga/run:/var/run/mysqld \
      -v /data/mroonga/data:/var/lib/mysql \
      sugi/mroonga

In this case, you can connect via unix domain socket;

    mysql --socket=/data/mroonga/run/mysqld.sock -u root

### Override settings

In addtion, you can override MySQL setting with
inserting your setting files at runtime;

    $ docker run --name mroonga -p 3306 \
      -v /data/mroonga/my-settings.cnf:/etc/mysql/conf.d/my-settings.cnf \
      sugi/mroonga

License
-------

Files in this repository are distributed under GPL v3.

Copyright
---------

Tatsuki Sugiura <sugi@nemui.org>
