Command to run tests

docker run -v 'Path To Reports':/opt/robotframework/reports:Z  -v 'Path To Tests':/opt/robotframework/tests:Z -v 'Path To Keywords':/opt/robotframework/tests/keywords:Z  --shm-size=2g digiroadvayla:noscript


Information about --shm-size=2g option
https://stepupautomation.wordpress.com/2020/04/02/resolved-chrome-firefox-crashed-when-running-on-docker-containers/

Go to https://github.com/ppodgorsek/docker-robot-framework for additional about dockerfile