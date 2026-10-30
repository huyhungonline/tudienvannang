"""Run a command with the running local backend's DB config, without logging secrets.

Usage: python tool/with_local_database.py python test/test_itpp_database.py
The caller may override LOCAL_BACKEND_CONTAINER (default dic-backend-1).
"""
import json
import os
import subprocess
import sys
from urllib.parse import urlsplit, urlunsplit


def main():
    container=os.getenv('LOCAL_BACKEND_CONTAINER','dic-backend-1')
    inspected=subprocess.check_output(['docker','inspect','--format','{{json .Config.Env}}',container],text=True)
    values=dict(item.split('=',1) for item in json.loads(inspected) if '=' in item)
    parsed=urlsplit(values['DATABASE_URL'])
    # PostgreSQL's compose service is exposed on the host's port 5432.
    host=os.getenv('ITPP_TEST_DB_HOST','127.0.0.1')
    netloc=parsed.netloc.rpartition('@')[0]+'@'+host+':'+str(parsed.port or 5432)
    env=dict(os.environ,DATABASE_URL=urlunsplit(parsed._replace(netloc=netloc)))
    print('Using database config from local backend container (credentials hidden)',flush=True)
    return subprocess.call(sys.argv[1:],env=env)


if __name__=='__main__':
    raise SystemExit(main())
