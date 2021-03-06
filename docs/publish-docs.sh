#!/usr/bin/env bash
echo ================================
echo Deploying AtlasMap documentation
echo ================================

../mvnw -Phtml,pdf package && \
../mvnw -f pom-javadoc.xml javadoc:aggregate && \
git clone -b gh-pages https://github.com/atlasmap/atlasmap.git gh-pages && \
git config --global user.email "travis@atlasmap.io" && \
git config --global user.name "Travis" && \
cp -rv target/generated-docs/html/user-guide/* gh-pages/ && \
cp -v target/generated-docs/pdf/user-guide/index.pdf gh-pages/user-guide.pdf && \
cp -rv target/generated-docs/html/developer-guide/ gh-pages/developer-guide && \
cp -v target/generated-docs/pdf/developer-guide/index.pdf gh-pages/developer-guide.pdf && \
cd gh-pages && \
git add --ignore-errors * && \
git commit -m "generated documentation" && \
git push origin gh-pages && \
cd ..
