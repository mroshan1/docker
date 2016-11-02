#!/bin/bash -xv

sleep 30
/usr/local/bin/mongo --host mongodb01:27017 <<EOF
   var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "mongodb01:27017",
                "priority": 1
            },
            {
                "_id": 1,
                "host": "mongodb02:27017",
                "priority": 1
            },
            {
                "_id": 2,
                "host": "mongodb03:27017",
                "priority": 1
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOF
