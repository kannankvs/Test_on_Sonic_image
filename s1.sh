#!/usr/bin bash -e
echo GIT CHECKOUT br2
git checkout -b br2
echo GIT config
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
echo GIT fetch
git fetch
echo GIT pushOriginBr2
git push origin br2
echo '{ KVSK2-Prasanna2 - is it working now?' > s1.json
echo "\n}" >> s1.json
echo GIT add
git add s1.json
git commit -m "latest links for sonic images"
echo GIT last push
git push -f --set-upstream origin br2
