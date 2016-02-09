#!/bin/bash
source activate memex_deploy
GIT_BRANCH='master' SECURITY_GROUP='memex-production' AWS_ID='' AWS_SECRET='' python ec2-fabfile.py
